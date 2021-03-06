% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/beach.R
\name{v_get_beach_round}
\alias{v_get_beach_round}
\title{Get a beach volleyball round}
\usage{
v_get_beach_round(no, fields)
}
\arguments{
\item{no}{integer: round number}

\item{fields}{character: fields to return}
}
\value{
A data.frame
}
\description{
Get a beach volleyball round
}
\examples{
\dontrun{
  v_get_beach_round(3054)
}

}
\references{
\url{https://www.fivb.org/VisSDK/VisWebService/#GetBeachRound.html}
}
