% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unstableFiltering.R
\name{unstableFiltering}
\alias{unstableFiltering}
\title{unstableFiltering}
\usage{
unstableFiltering(group = c("sudo", "docker"), scratch.folder, file,
  nCluster, separator, sThreshold)
}
\arguments{
\item{group, }{a character string. Two options: sudo or docker, depending to which group the user belongs}

\item{scratch.folder, }{a character string indicating the path of the scratch folder}

\item{file, }{a character string indicating the path of the file, with file name and extension included}

\item{nCluster, }{number of clusters}

\item{separator, }{separator used in count file, e.g. '\\t', ','}

\item{sThreshold, }{cell stability score threshold, a value between 0 and 1.}
}
\value{
A filtered counts file
}
\description{
This function executes a ubuntu docker that remove cells on the basis of their cell stability score.
}
\examples{
\dontrun{
unstableFiltering(group="docker", scratch.folder="/media/lucastormreig/8799-82B32/PHD/CASC8.1Stable/CASC8.0STABLE/new/unstableFiltering/scratch/", file="/media/lucastormreig/8799-82B32/PHD/CASC8.1Stable/CASC8.0STABLE/new/unstableFiltering/data/testset.txt",nCluster=5, separator="\\t",sThreshold=0.75)
}
}
\author{
Luca Alessandri, alessandri [dot] luca1991 [at] gmail [dot] com, University of Torino
}
