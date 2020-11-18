#' Set or get fivbvis options
#'
#' @param verbose logical: if `TRUE`, display progress information
#'
#' @return The current options (invisibly unless at least one parameter has been provided)
#'
#' @export
v_options <- function(verbose = FALSE) {
    opts <- options()$fivbvis
    if (!missing(verbose)) {
        assert_that(is.flag(verbose), !is.na(verbose))
        opts$verbose <- verbose
    }
    if (missing(verbose)) {
        ## if all inputs missing, return opts
        opts
    } else {
        ## update opts and return invisibly
        options(fivbvis = opts)
        invisible(opts)
    }
}


## internal convenience function
v_verbose <- function() isTRUE(v_options()$verbose)
