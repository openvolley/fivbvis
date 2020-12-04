#' Set or get fivbvis options
#'
#' @param verbose logical: if `TRUE`, display progress information
#'
#' @return The current options (invisibly unless at least one parameter has been provided)
#'
#' @export
v_options <- function(verbose = FALSE) {
    opts <- options()$fivbvis
    if (length(opts) < 1) opts <- v_set_default_options() ## somehow we started without setting the options
    if (!missing(verbose)) {
        assert_that(is.flag(verbose), !is.na(verbose))
        opts$verbose <- verbose
    }
    if (missing(verbose)) {
        ## if called without any inputs, return opts
        opts
    } else {
        ## update opts and return invisibly
        options(fivbvis = opts)
        invisible(opts)
    }
}


## internal convenience functions
v_verbose <- function() isTRUE(v_options()$verbose)

v_set_default_options <- function() {
    opts0 <- options()$fivbvis
    if (!is.null(opts0) && !is.null(opts0$session_cache_dir) && dir.exists(opts0$session_cache_dir)) {
        scd <- opts0$session_cache_dir
    } else {
        scd <- tempfile()
        dir.create(scd)
    }
    opts <- list(caching = TRUE, verbose = FALSE, cache_dir = scd, session_cache_dir = scd)
    options(fivbvis = opts)
    opts
}
