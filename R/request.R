base_url <- "https://www.fivb.org/Vis2009/XmlRequest.asmx"

first_to_upper <- function(z) paste0(toupper(substr(z, 1, 1)), substr(z, 2, nchar(z)))

## internal helper function to build the XML request structure
## any extra arguments passed to this function (i.e. anything other than type, fields, version, filter, or old_style)
##  are added to the xml request as attributes (e.g. "No", "NoTournament" for some requests)
##  note that the first letter of these parameters is capitalized when added to the xml BUT we need to be careful with CamelCased
##  parameters like NoTournament (i.e. the call must be like `v_request(xyz, NoTournament = 123)` )
v_request <- function(type, fields, version, filter, old_style = FALSE, ...) {
    body <- minixml::xml_elem("Request", Type = type)
    dots <- Filter(Negate(is.null), list(...))
    if (length(dots)) {
        names(dots) <- first_to_upper(names(dots))
        body <- do.call(body$update, dots)
    }
    if (!missing(fields) && length(fields)) body <- body$update(Fields = paste(fields, collapse = " "))
    if (isTRUE(old_style)) {
        ## the old request style was
        ## <Requests Username="xxx" Password="xxx">
        ##   <!-- Zero or more <Request> entries -->
        ## </Requests>
        body <- minixml::xml_elem("Requests")$append(body)
    }
    body
}


## return_type can be "parsed" (convert XML to data frame) or (probably for testing purposes) "content" (unparsed content) or "response" (the response object)
make_request <- function(request, type = "xml", return_type = "parsed", node_path, convert_cols = TRUE, as_tibble = TRUE, cache = v_caching(), huge = FALSE) {
    hash <- paste0(digest::digest(list(request = request, type = type)), ".rds")
    return_type <- match.arg(tolower(return_type), c("content", "response", "parsed"))
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
    if (v_verbose()) {
        req_type <- NULL
        try({
            req_type <- request$attribs$Type
            if (is.null(req_type)) req_type <- unique(unlist(lapply(request$children, function(z) z$attribs$Type)))
        }, silent = TRUE)
        message("making ", req_type, " request")
    }
    if (isTRUE(huge)) {
        opts0 <- v_options()
        on.exit(v_restore_options(opts0))
        v_options(huge_xml = TRUE)
    }
    out <- do_make_request(request = request, type = type, return_type = return_type, node_path = node_path)
    if (isTRUE(cache) || cache %in% "refresh") {
        if (v_verbose()) message("caching to ", cfname)
        saveRDS(out, file = cfname)
    }
    if (return_type == "parsed") {
        if (isTRUE(convert_cols)) {
            ## all columns will be character at this point
            ## attempt to convert columns into appropriate types
            try(out <- data.table::fread(text = capture.output(write.csv(out, row.names = FALSE)), data.table = FALSE), silent = TRUE)
        }
        if (isTRUE(as_tibble)) out <- tibble::as_tibble(out)
    }
    out
}

do_make_request <- function(request, type = "xml", return_type, node_path) {
    if (inherits(request, "XMLElement")) request <- as.character(request)
    type <- match.arg(tolower(type), c("json", "xml"))
    cf <- if (type == "json") httr::accept_json() else httr::accept_xml()
    return_type <- match.arg(tolower(return_type), c("content", "response", "parsed"))
    out <- httr::POST(url = base_url, config = cf, body = request)
    if (return_type == "response") return(out)
    response_type <- httr::http_type(out)
    out <- httr::content(out, as = "text", encoding = "UTF-8")
    if (return_type == "content") return(out)
    xml_parse_options <- c(XML::RECOVER, if (isTRUE(v_options()$huge_xml)) c(XML::COMPACT, XML::HUGE))
    if (response_type == "application/xml") {
        if (!missing(node_path)) {
            ## use XML:::xmlAttrsToDataFrame
            out <- XML:::xmlAttrsToDataFrame(XML::getNodeSet(XML::xmlParse(out, asText = TRUE, options = xml_parse_options), path = node_path))
        } else {
            out <- XML::xmlToList(XML::xmlParse(out, asText = TRUE, options = xml_parse_options))
            if (is.character(out)) {
                try(out <- as.data.frame(as.list(out), stringsAsFactors = FALSE), silent = TRUE)
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
                }, silent = TRUE)
            }
        }
        out
    } else if (response_type == "application/json") {
        jsonlite::fromJSON(out)
    } else {
        stop("unexpected response type: ", response_type)
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
    opts <- v_options()
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
    opts <- v_options()
    if (!missing(cache_dir) && !is.null(cache_dir)) {
        if (is.string(cache_dir)) {
            if (identical(tolower(cache_dir), "user")) {
                cache_dir <- rappdirs::user_data_dir(appname = "fivbvis")
                if (!dir.exists(cache_dir)) dir.create(cache_dir, recursive = TRUE)
            } else if (identical(tolower(cache_dir), "session")) {
                cache_dir <- opts$session_cache_dir
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

