#!/usr/bin/env Rscript

country.code <- 'us'  # use yours
url.pattern <- 'https://'  # use http if you want
repo.data.frame <- subset(getCRANmirrors(), CountryCode == country.code & grepl(url.pattern, URL))
options(repos = repo.data.frame$URL)
options(download.file.method="libcurl")

library(miniCRAN)
library(parallel)
packages <- read.table("/work/Rlibs/package.txt")
tags <- as.vector(unlist(packages))
dep <- pkgDep(tags, type="source",suggests=F,enhances=F)
makeRepo(dep, path="/work/Rlibs/source",type=c("source"))
cores <- detectCores()
for (i in 1:length(tags)) {
    install.packages(paste(tags[i]), repos=file.path("file://","/work/Rlibs/source"), type="source", lib="/work/Rlibs/build", Ncpus=getOption("Ncpus", cores))
}
