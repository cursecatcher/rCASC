% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/permutationClustering.R
\name{permutationClustering}
\alias{permutationClustering}
\title{Permutations and Clustering}
\usage{
permutationClustering(group = c("sudo", "docker"), scratch.folder, file,
  nPerm, permAtTime, percent, range1 = 3, range2 = 3, separator,
  logTen = 0, clustering, perplexity = 10, seed = 1111, rK = 0)
}
\arguments{
\item{group, }{a character string. Two options: sudo or docker, depending to which group the user belongs}

\item{scratch.folder, }{a character string indicating the path of the scratch folder}

\item{file, }{a character string indicating the path of the file, with file name and extension included}

\item{nPerm, }{number of permutations to perform the pValue to evaluate clustering}

\item{permAtTime, }{number of permutations that can be computes in parallel}

\item{percent, }{percentage of randomly selected cells removed in each permutation}

\item{range1, }{first number of cluster for k means algorithm}

\item{range2, }{last number of cluster for k means algorithm}

\item{separator, }{separator used in count file, e.g. '\\t', ','}

\item{logTen, }{1 if the count matrix is already in log10, 0 otherwise}

\item{clustering, }{clustering method to use : "SIMLR" , "tSne", "griph"}

\item{perplexity, }{Number of close neighbors for each point. This parameter is specific for tSne. Default value is 10.Setting this parameter when use a clustering method different by tSne will be ignored.}

\item{seed, }{important value to reproduce the same results with same input}

\item{rK, }{1 for rankGene algorithm 0 otherwise WARNING, very slow with this feature. This parameter is specific for SIMLR. Setting this parameter to 1 with other clustering methods will not give any different result to set the parameter to 0.}
}
\value{
VioPlot of silhouette cells value for each number of cluster used,clusterP file with clustering results for each permutation, killedCell file with removed cells in each permutation, clustering.output a sommarize file with general information for each cells.
}
\description{
This function executes a ubuntu docker that produces a specific number of permutation to evaluate clustering.
}
\examples{
\dontrun{
 permutationClustering("docker","/home/lucastormreig/CASC2.0/permutationClustering/scratch/","/home/lucastormreig/CASC2.0/permutationClustering/Data/TOTAL.csv",4,2,10,3,4,separator=",",logTen=0,clustering="SIMLR",perplexity=0)
}
}
\author{
Luca Alessandri, alessandri [dot] luca1991 [at] gmail [dot] com, University of Torino
}
