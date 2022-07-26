#' Set or get fivbvis options
#'
#' @param verbose logical: if `TRUE`, display progress information
#' @param huge_xml logical: if `TRUE`, set the XML parsing options to allow "huge" (i.e. deeply-nested) XML documents to be parsed
#'
#' @return The current options (invisibly unless at least one parameter has been provided)
#'
#' @export
v_options <- function(huge_xml = FALSE, verbose = FALSE) {
  opts <- options()$fivbvis
  if (length(opts) < 1) opts <- v_set_default_options() ## somehow we started without setting the options
  if (!missing(verbose)) {
    assert_that(is.flag(verbose), !is.na(verbose))
    opts$verbose <- verbose
  }
  if (!missing(huge_xml)) {
    assert_that(is.flag(huge_xml), !is.na(huge_xml))
    opts$huge_xml <- huge_xml
  }
  if (missing(verbose) && missing(huge_xml)) {
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
  opts <- list(caching = TRUE, verbose = FALSE, cache_dir = scd, session_cache_dir = scd, huge_xml = FALSE)
  options(fivbvis = opts)
  opts
}

## unconditionally reset options to a known set
v_restore_options <- function(opts) {
  options(fivbvis = opts)
}
