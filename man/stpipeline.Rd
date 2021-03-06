% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spatialPipe.R
\name{stpipeline}
\alias{stpipeline}
\title{Spatial transcriptomics pipeline}
\usage{
stpipeline(group = c("sudo", "docker"), scratch.folder, data.folder,
  genome.folder, gtf, f1 = NULL, f2 = NULL, nameExp, ids)
}
\arguments{
\item{group, }{a character string. Two options: sudo or docker, depending to which group the user belongs}

\item{scratch.folder, }{a character string indicating the path of the scratch folder}

\item{data.folder, }{a character string indicating the path of the data folder. GTF, ids and fasta files have to be here.Results will be copied in this folder}

\item{genome.folder, }{a character string indicating the path of the genome folder.}

\item{gtf, }{boh}

\item{f1, }{a character string indicating the name of first fasta file}

\item{f2, }{a character string indicating the name of second fasta file}

\item{nameExp, }{a character string indicating the name of the experiment}

\item{ids, }{a character string indicating the name of the ids(barcodes txt files)}
}
\value{
count matrix from spatial transcriptomics
}
\description{
Create count matrix from spatial transcriptomics fasta
}
\examples{
\dontrun{

}
}
\author{
Luca Alessandri , alessandri [dot] luca1991 [at] gmail [dot] com, University of Torino
}
