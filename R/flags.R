#' Retrieve a country flag image
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#Country%20flags%20(small).html}
#' @param country_code string: the ISO 3166-1 alpha-2 code of the country. For federations, you need to convert the federation code to the equivalent country code. If there is no equivalent country (for ENG, NIR, SCO, WAL), you can use the 3 letters federation code to retrieve the flag.
#'
#' @return Path to image file
#'
#' @examples
#' \dontrun{
#'   v_flag("AU")
#' }
#'
#' @export
v_flag <- function(country_code) {
  tf <- tempfile(fileext = ".png")
  assert_that(is.string(country_code))
  url <- paste0("https://www.fivb.org/Vis2009/Images/Flags/Small/", toupper(country_code), ".png")
  cached_get_file(url, fileext = ".png")
}
