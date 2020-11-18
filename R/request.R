base_url <- "https://www.fivb.org/Vis2009/XmlRequest.asmx"

make_request <- function(body, type = "xml", cache = v_caching()) {
    hash <- paste0(digest::digest(list(body = body, type = type)), ".rds")
    cfname <- file.path(v_cache_dir(), hash)
    if (isTRUE(cache) && file.exists(cfname) && file.size(cfname) > 0) {
        cok <- FALSE
        try({
            out <- readRDS(cfname)
            cok <- TRUE
        }, silent = TRUE)
        if (cok) {
            if (v_verbose()) message("using cached file ", cfname)
            return(out)
        }
    }
    if (v_verbose()) message("making request to ", tryCatch(body$attribs$Type, error = function(e) NULL))
    out <- do_make_request(body = body, type = type)
    if (isTRUE(cache) || cache %in% "refresh") {
        if (v_verbose()) message("caching to ", cfname)
        saveRDS(out, file = cfname)
    }
    out
}

do_make_request <- function(body, type = "xml") {
    if (inherits(body, "XMLElement")) body <- as.character(body)
    type <- match.arg(tolower(type), c("json", "xml"))
    cf <- if (type == "json") httr::accept_json() else httr::accept_xml()
    out <- httr::POST(url = base_url, config = cf, body = body)
    if (httr::http_type(out) == "application/xml") {
        out <- XML::xmlToList(XML::xmlParse(httr::content(out, as = "text", encoding = "UTF-8"), asText = TRUE))
        if (is.character(out)) {
            try(out <- as.data.frame(as.list(out), stringsAsFactors = FALSE))
        } else {
            attrs <- NULL
            if (".attrs" %in% names(out)) {
                attrs <- out$.attrs
                out$.attrs <- NULL
            }
            try({
                out <- do.call(rbind, lapply(out, function(z) as.data.frame(as.list(z), stringsAsFactors = FALSE)))
                rownames(out) <- NULL
                for (aa in names(attrs)) attr(out, aa) <- attrs[[aa]]
            })#, silent = TRUE)
        }
        out
    } else if (httr::http_type(out) == "application/json") {
        jsonlite::fromJSON(httr::content(out, as = "text"))
    } else {
        stop("unexpected response type: ", httr::http_type(out))
    }
}


cached_get_file <- function(url, fileext, cache = v_caching()) {
    hash <- digest::digest(url)
    if (!missing(fileext)) hash <- paste0(hash, fileext)
    cfname <- file.path(v_cache_dir(), hash)
    if (!(isTRUE(cache) && file.exists(cfname))) download.file(url, destfile = cfname)
    cfname
}

#' Get or set fivbvis caching behaviour
#'
#' By default, fivbvis starts with session-specific caching (equivalent to running `v_caching(TRUE); v_cache_dir("session")`).
#'
#' @param caching logical or string: if `TRUE`, used cached results; if `FALSE`, no caching; if `"refresh"`, refresh the cache
#' @param cache_dir string: either
#' \itemize{
#'   \item "session" - use a session-specific directory for caching, meaning that when R is closed and restarted, the cache will be cleared and a new one used
#'   \item "user" - use a persistent, user-specific directory (as returned by \code{\link[rappdirs]{user_data_dir}}
#'   \item or a string giving a path to a specific directory to use. The directory must already exist
#' }
#'
#' @return The caching setting (for `v_caching`) or cache directory (for `v_cache_dir`) after applying any provided parameters
#'
#' @examples
#'
#' v_caching(TRUE) ## turn caching on
#' v_caching(FALSE) ## turn caching off
#' v_caching("refresh") ## contents in cache will be updated
#'
#' v_cache_dir() ## return current cache dir
#' \dontrun{
#'   v_cache_dir("session") ## use per-session cache
#'   v_cache_dir("user") ## use persistent, user-specific cache
#'   v_cache_dir("c:/my/cache/dir") ## use specific dir
#' }
#'
#' @export
v_caching <- function(caching) {
    opts <- options()$fivbvis
    if (!missing(caching) && !is.null(caching)) {
        if ((is.logical(caching) && !is.na(caching)) || (is.string(caching) && tolower(caching) == "refresh")) {
            opts$caching <- caching
            options(fivbvis = opts)
        } else {
            stop("caching must be TRUE, FALSE, or \"refresh\"")
        }
    }
    if (missing(caching)) opts$caching else invisible(opts$caching)
}

#' @export
#' @rdname v_caching
v_cache_dir <- function(cache_dir) {
    opts <- options()$fivbvis
    if (!missing(cache_dir) && !is.null(cache_dir)) {
        if (is.string(cache_dir)) {
            if (identical(tolower(cache_dir), "user")) {
                cache_dir <- rappdirs::user_data_dir(appname = "fivbvis")
                if (!dir.exists(cache_dir)) dir.create(cache_dir, recursive = TRUE)
            } else if (identical(tolower(cache_dir), "session")) {
                cache_dir <- v_options()$session_cache_dir
            }
            if (dir.exists(cache_dir)) {
                opts$cache_dir <- cache_dir
                options(fivbvis = opts)
            } else {
                stop("cache_dir must be \"user\", \"session\", or a path to an existing directory")
            }
        } else {
            stop("cache_dir must be \"user\", \"session\", or a path to an existing directory")
        }
    }
    if (missing(cache_dir)) opts$cache_dir else invisible(opts$cache_dir)
}

