% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seuratPermutation.R
\name{seuratPermutation}
\alias{seuratPermutation}
\title{Seurat Permutation}
\usage{
seuratPermutation(group = c("sudo", "docker"), scratch.folder, file,
  nPerm, permAtTime, percent, separator, logTen = 0, pcaDimensions,
  seed = 1111, sparse = FALSE, format = "NULL")
}
\arguments{
\item{group, }{a character string. Two options: sudo or docker, depending to which group the user belongs}

\item{scratch.folder, }{a character string indicating the path of the scratch folder}

\item{file, }{a character string indicating the path of the file, with file name and extension included}

\item{nPerm, }{number of permutations to perform the pValue to evaluate clustering}

\item{permAtTime, }{number of permutations that can be computes in parallel}

\item{percent, }{percentage of randomly selected cells removed in each permutation}

\item{separator, }{separator used in count file, e.g. '\\t', ','}

\item{logTen, }{1 if the count matrix is already in log10, 0 otherwise}

\item{pcaDimensions, }{0 for automatic selection of PC elbow.}

\item{seed, }{important value to reproduce the same results with same input}

\item{sparse, }{boolean for sparse matrix}

\item{format, }{output file format csv or txt}
}
\value{
To write
}
\description{
This function executes a ubuntu docker that produces a specific number of permutation to evaluate clustering.
}
\examples{
\dontrun{
 system("wget http://130.192.119.59/public/section4.1_examples.zip")
 unzip("section4.1_examples.zip")
 setwd("section4.1_examples")
 system("wget ftp://ftp.ensembl.org/pub/release-94/gtf/homo_sapiens/Homo_sapiens.GRCh38.94.gtf.gz")
 system("gzip -d Homo_sapiens.GRCh38.94.gtf.gz")
 system("mv Homo_sapiens.GRCh38.94.gtf genome.gtf")
 scannobyGtf(group="docker", file=paste(getwd(),"bmsnkn_5x100cells.txt",sep="/"),
             gtf.name="genome.gtf", biotype="protein_coding", 
             mt=TRUE, ribo.proteins=TRUE,umiXgene=3)
 
 seuratBootstrap(group="docker",scratch.folder="/data/scratch/",
      file=paste(getwd(), "annotated_bmsnkn_5x100cells.txt", sep="/"), 
      nPerm=160, permAtTime=8, percent=10, separator="\\t",
      logTen=0, pcaDimensions=6, seed=111)
}
}
\author{
Luca Alessandri, alessandri [dot] luca1991 [at] gmail [dot] com, University of Torino
}
