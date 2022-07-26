#' Get an event
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetEvent.html}
#' @param no integer: the number of event
#' @param fields character: fields to return
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#' v_get_event(1)
#' }
#'
#' @export
v_get_event <- function(no, fields) {
  ##  <Request Type="GetEvent"
  ##           No="<event number>"
  ##           Fields="<optional: list of the fields to return>" />
  req <- v_request(type = "GetEvent", no = no, fields = fields)
  out <- make_request(req, node_path = "//Event")
  out <- v_remap(out, col = "OrganizerType", schema = "Organizer Type")
  v_remap(out, col = "Type", schema = "Event Type")
}


#' Get an event list
#'
#' @references \url{https://www.fivb.org/VisSDK/VisWebService/#GetEventList.html}
#' @param fields character: fields to return
#' @param version integer: version of local list (currently ignored)
#' @param filter list: (currently ignored)
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun{
#' v_get_event_list()
#' }
#'
#' @export
v_get_event_list <- function(fields = v_fields("Event"), version, filter) {
  ##  <Request Type="GetEventList"
  ##           Fields="<list of the fields to return>">
  ##    <Filter /> <!-- Optional: contains the filter to use -->
  ##  </Request>
  req <- v_request(type = "GetEventList", fields = fields, version = version, filter = filter)
  make_request(request = req, node_path = "//Event")
}
