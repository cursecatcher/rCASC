#' @title A function allowing the identification of differentially expressed genes.
#' @description This function executes in a docker edgeR for the idnetification of differentially expressed genes in single-cells RNAseq
#' @param group, a character string. Two options: sudo or docker, depending to which group the user belongs
#' @param data.folder, a character string indicating the folder where input data are located and where output will be written
#' @param counts.table, a character string indicating the counts table file. IMPORTANT in the header of the file the covariate group MUST be associated to the column name using underscore, e.g. cell1_cov1
#' @param file.type, type of file: txt tab separated columns csv comma separated columns
#' @param logFC.threshold, minimal logFC present in at least one of the comparisons with respect to reference covariate
#' @param FDR.threshold, minimal FDR present in at least one of the comparisons with respect to reference covariate
#' @param logCPM.threshold, minimal average abundance
#' @param plot, TRUE if differentially expressed genes are represented in a plot.
#' @author Raffaele Calogero, raffaele.calogero [at] unito [dot] it, University of Torino, Italy
#'
#' @examples
#' \dontrun{
#'     #running deDetection
#'     system("wget http://130.192.119.59/public/buettner_counts_noSymb.txt.zip")
#'     unzip("buettner_counts_noSymb.txt.zip")
#'     lorenzFilter(group="docker", scratch.folder="/data/scratch/",
#'                 data.folder=getwd(), matrixName="buettner_counts_noSymb",
#'                 p_value=0.05, format="txt", separator='\t')
#'
#'     system("wget ftp://ftp.ensembl.org/pub/release-92/gtf/mus_musculus/Mus_musculus.GRCm38.92.gtf.gz")
#'     system("gzip -d Mus_musculus.GRCm38.92.gtf.gz")
#'     scannobyGtf(group="docker", data.folder=getwd(),
#'                  counts.table="lorenz_buettner_counts_noSymb.txt",
#'                  gtf.name="Mus_musculus.GRCm38.92.gtf",
#'                  biotype="protein_coding", mt=FALSE, ribo.proteins=FALSE,
#'                  file.type="txt", umiXgene=3)
#'
#'     deDetection(group="docker", data.folder=getwd(),
#'                counts.table="annotated_lorenz_buettner_counts_noSymb.txt",
#'                file.type="txt", logFC.threshold=1, FDR.threshold=0.05, logCPM.threshold=4, plot=TRUE)
#' }
#'
#' @export
deDetection <- function(group=c("sudo","docker"), data.folder, counts.table, file.type=c("txt","csv"), logFC.threshold=1, FDR.threshold, logCPM.threshold=4, plot=c(TRUE, FALSE)){

  #running time 1
  ptm <- proc.time()
  #setting the data.folder as working folder
  if (!file.exists(data.folder)){
    cat(paste("\nIt seems that the ",data.folder, " folder does not exist\n"))
    return(2)
  }

  #storing the position of the home folder
  home <- getwd()
  setwd(data.folder)
  #initialize status
  system("echo 0 >& ExitStatusFile")

  #testing if docker is running
  test <- dockerTest()
  if(!test){
    cat("\nERROR: Docker seems not to be installed in your system\n")
    system("echo 10 >& ExitStatusFile")
    setwd(home)
    return(10)
  }

  #executing the docker job
  params <- paste("--cidfile ",data.folder,"/dockerID -v ", data.folder, ":/data -d docker.io/repbioinfo/desc.2018.01 Rscript /bin/desc.R ", counts.table, " ", file.type, sep="")
  resultRun <- runDocker(group=group, params=params)

  #waiting for the end of the container work
  if(resultRun==0){
    cat("\nDifferential expression analysis is finished\n")
  }

  tmp0 <- read.table(paste("DE_", counts.table, sep=""), sep="\t", header=T, row.names=1)
  max0.logfc.tmp <- apply(tmp0[,grep("logFC", names(tmp0))], 1, function(x) unique(x[which(abs(x)== max(abs(x)))]))
  max0.logfc <- sapply(max0.logfc.tmp, function(x)as.numeric(x[[1]]))

  tmp <- tmp0[which(tmp0$logCPM >= logCPM.threshold),]
  max.logfc <- apply(tmp[,grep("logFC", names(tmp))], 1, function(x) max(abs(x)))
  tmp <- tmp[which(max.logfc >= logFC.threshold),]
  tmp <- tmp[which(tmp$FDR <= FDR.threshold),]
  max1.logfc.tmp <- apply(tmp[,grep("logFC", names(tmp))], 1, function(x){
    x[which(abs(x)== max(abs(x)))]
  })
  max1.logfc <- sapply(max1.logfc.tmp, function(x)as.numeric(x[[1]]))
  if(plot){
  	pdf("filteredDE.pdf")
    	plot(tmp0$logCPM, max0.logfc, xlab="log2CPM", ylab="log2FC", type="n")
    	points(tmp$logCPM, max1.logfc, pch=19, cex=0.5, col="red")
    	points(tmp0$logCPM, max0.logfc, pch=".", col="black")
    	abline(h=0, col="black", lty=2)
  	  dev.off()
 }
write.table(tmp, paste("filtered_DE_", counts.table, sep=""), sep="\t", col.names=NA)

  #running time 2
  ptm <- proc.time() - ptm
  dir <- dir(data.folder)
  dir <- dir[grep("run.info",dir)]
  if(length(dir)>0){
    con <- file("run.info", "r")
    tmp.run <- readLines(con)
    close(con)
    tmp.run[length(tmp.run)+1] <- paste("user run time mins ",ptm[1]/60, sep="")
    tmp.run[length(tmp.run)+1] <- paste("system run time mins ",ptm[2]/60, sep="")
    tmp.run[length(tmp.run)+1] <- paste("elapsed run time mins ",ptm[3]/60, sep="")
    writeLines(tmp.run,"run.info")
  }else{
    tmp.run <- NULL
    tmp.run[1] <- paste("DE detection run time mins ",ptm[1]/60, sep="")
    tmp.run[length(tmp.run)+1] <- paste("DE detection system run time mins ",ptm[2]/60, sep="")
    tmp.run[length(tmp.run)+1] <- paste("DE detection elapsed run time mins ",ptm[3]/60, sep="")

    writeLines(tmp.run,"run.info")
  }

  #saving log and removing docker container
  container.id <- readLines(paste(data.folder,"/dockerID", sep=""), warn = FALSE)
  system(paste("docker logs ", substr(container.id,1,12), " &> ",data.folder,"/", substr(container.id,1,12),".log", sep=""))
  system(paste("docker rm ", container.id, sep=""))
  #removing temporary folder
  cat("\n\nRemoving the temporary file ....\n")
  system("rm -fR dockerID")
  system(paste("cp ",paste(path.package(package="rCASC"),"containers/containers.txt",sep="/")," ",data.folder, sep=""))
  setwd(home)
}
