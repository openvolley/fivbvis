#' Get a list of press releases
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetPressReleaseList.html}
#' @param no integer: the number of press releases to return
#' @param startindex integer: index of the first press release to return
#' @param fields character: fields to return
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_press_release_list(10)
#' }
#'
#' @export
v_get_press_release_list <- function(no, startindex = 1, filter, fields = v_fields("Press Release")) {
  ## <Request Type="GetPressReleaseList"
  ##          Number="10"
  ##          StartIndex="11"
  ##          Fields="<list of the fields to return>">
  ##      <Filter /> <!-- Optional: contains the filter to use -->
  ##      </Request>
  req <- v_request(type = "GetPressReleaseList", no = no, startindex = startindex, fields = fields, filter = filter, old_style = TRUE)
  out <- make_request(request = req, node_path = "//PressRelease")
  out <- v_remap(out, col = "Category", schema = "Press Release Category")
  out <- v_remap(out, col = "SpecialType", schema = "Press Release Special Type")
  v_remap(out, col = "SourceCategory", schema = "Press Release Source Category")
}


#' Get a press release text
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetPressReleaseText.html}
#' @param no integer: press release number
#' @param fields character: fields to return
#' @param language string: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#'   v_get_press_release_text(28639)
#' }
#'
#' @export
v_get_press_release_text <- function(no, language, fields = v_fields("Press Release Text")) {
  ##  <Request Type="GetPressReleaseText"
  ##           No="<press release number>"
  ##           Language="<language for the text>"
  ##           Fields="<optional: list of the fields to return>" />
  req <- v_request(type = "GetPressReleaseText", no = no, fields = fields, old_style = TRUE)
  out <- make_request(request = req, node_path = "//PressReleaseText")
  out <- v_remap(out, col = "Category", schema = "Press Release Category")
  out <- v_remap(out, col = "SourceCategory", schema = "Press Release Source Category")
  v_remap(out, col = "SpecialType", schema = "Press Release Special Type")
}


## TODO https://www.fivb.org/VisSDK/VisWebService/#GetPressReleaseTextList.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetArticle.html
## TODO https://www.fivb.org/VisSDK/VisWebService/#GetArticleList.html
