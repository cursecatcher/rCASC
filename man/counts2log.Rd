% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/counts2log.R
\name{counts2log}
\alias{counts2log}
\title{A function to convert raw count in log counts}
\usage{
counts2log(file, log.base = c(2, 10))
}
\arguments{
\item{file, }{a character string indicating the path of the file. IMPORTANT: full path to the file MUST be included.}

\item{log.base, }{the base of the log to be used for the transformation}
}
\value{
log transformed table
}
\description{
This function convert raw counts in log format
}
\examples{
\dontrun{
    system("wget http://130.192.119.59/public/TO BE INSERTED")
    #running skeleton
    counts2log(file=paste(getwd(), "example_UMI.txt", sep="/"), log.base=10)
}

}
\author{
Raffaele Calogero, raffaele.calogero [at] unito [dot] it, University of Torino
}
