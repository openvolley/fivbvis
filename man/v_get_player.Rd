% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/players.R
\name{v_get_player}
\alias{v_get_player}
\title{Get a player}
\usage{
v_get_player(no, fields)
}
\arguments{
\item{no}{integer: the number of the player}

\item{fields}{character: fields to return}
}
\value{
A data.frame
}
\description{
Get a player
}
\examples{
\dontrun{
  v_get_player(100002)
}

}
\references{
\url{https://www.fivb.org/VisSDK/VisWebService/#GetPlayer.html}
}
