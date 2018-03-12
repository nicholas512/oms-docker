#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
library(miniCRAN)
library(parallel)

download <- function(tags) {
    country.code <- 'us'  # use yours
    url.pattern <- 'https://'  # use http if you want
    repo.data.frame <- subset(getCRANmirrors(), CountryCode == country.code & grepl(url.pattern, URL))
    options(repos = repo.data.frame$URL)
    options(download.file.method="libcurl")
    dep <- pkgDep(tags, type="source",suggests=F,enhances=F)
    makeRepo(dep, path="/work/Rlibs/source",type=c("source"))
}

install <- function(tags) {
    cores <- detectCores()
    for (i in 1:length(tags)) {
        install.packages(paste(tags[i]), repos=file.path("file://","/work/Rlibs/source"), type="source", lib="/work/Rlibs/build", Ncpus=getOption("Ncpus", cores))
    }
}

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

instruction <- args[1]
packages <- read.table("/work/Rlibs/package.txt")
tags <- as.vector(unlist(packages))

if (instruction == "i") install(tags)
if (instruction == "di") {
    download(tags)
    install(tags)
}
