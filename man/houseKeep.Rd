% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/houseKeep.R
\name{houseKeep}
\alias{houseKeep}
\title{houseKeep Filtering}
\usage{
houseKeep(group = c("sudo", "docker"), scratch.folder, file, separator,
  logTen, geneNameControl = 1, houseK, topCell)
}
\arguments{
\item{group, }{a character string. Two options: sudo or docker, depending to which group the user belongs}

\item{scratch.folder, }{a character string indicating the path of the scratch folder}

\item{file, }{a character string indicating the path of the file, with file name and extension included}

\item{separator, }{separator used in count file, e.g. '\\t', ','}

\item{logTen, }{0 if is raw count, 1 otherwise}

\item{geneNameControl, }{0 if the matrix has gene name without ENSEMBL geneID. 1 if the gene names is formatted as: ENSMUSG00000000001:Gnai3. If the gene names is made only by ensamble name, scannoByGtf has to be run first.}

\item{houseK, }{to be described ....}

\item{topCell, }{to be described ...}
}
\value{
return matrix filtered by the best cells that have housekeepin genes most expressed
}
\description{
This function filter your matrix count on a specific gene house keepin list
}
\examples{
\dontrun{
housekeep("docker","/home/lucastormreig/scratch/","/home/lucastormreig/CASC7.2/6_1hfc/Data/random_10000_filtered_annotated_lorenz_naive_penta2_0",6,",","naive")#
}
}
\author{
Luca Alessandri , alessandri [dot] luca1991 [at] gmail [dot] com, University of Torino
}
