.onAttach <- function(libname, pkgname) {
    scd <- tempfile()
    dir.create(scd)
    opts <- list(caching = TRUE, verbose = FALSE, cache_dir = scd, session_cache_dir = scd)
    options(fivbvis = opts)
}

