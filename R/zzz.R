.onAttach <- function(libname, pkgname) {
    opts0 <- options()$fivbvis
    if (!is.null(opts0) && !is.null(opts0$session_cache_dir) && dir.exists(opts0$session_cache_dir)) {
        scd <- opts0$session_cache_dir
    } else {
        scd <- tempfile()
        dir.create(scd)
    }
    opts <- list(caching = TRUE, verbose = FALSE, cache_dir = scd, session_cache_dir = scd)
    options(fivbvis = opts)
}

