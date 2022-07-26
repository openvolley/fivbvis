## remap values from one set to another set
dmapvalues <- function(x, from, to, .default = NA, ...) {
  if (is.na(.default)) try(.default <- as(NA, class(to)), silent = TRUE)
  stopifnot(length(from) == length(to))
  map <- to
  names(map) <- from
  temp <- setdiff(x, from)
  if (length(temp)) {
    extra <- rep(.default, length(temp))
    names(extra) <- temp
    map <- c(map, extra)
  }
  if (is.numeric(x)) x <- as.character(x)
  unname(map[x])
}
## str(dmapvalues(10:0, 0:5, letters[1:6]))
## see also v_remap
