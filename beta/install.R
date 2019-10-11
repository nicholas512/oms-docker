#!/usr/bin/env Rscript

install.packages(c("pkgconfig","Matrix","magrittr",
                   "irlba","R6","sys","askpass",
                   "openssl","curl","mime","jsonlite",
                   "igraph","XML","httr","miniCRAN",
                   "Rcpp", INSTALL_opts=c('--no-lock')),
repos="http://lib.stat.cmu.edu/R/CRAN")
