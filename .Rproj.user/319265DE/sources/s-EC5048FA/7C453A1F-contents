
x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) {
    for(j in seq_len(ncol(x))) {
        print(x[i, j])
    }   
}


for(i in 1:100) {
    if(i <= 20) {
        ## Skip the first 20 iterations
        next                 
    }
    ## Do something here
}


for(i in 1:100) {
    print(i)
    
    if(i > 20) {
        ## Stop loop after 20 iterations
        break  
    }     
}


# An example 
check_for_logfile <- function(date) {
    year <- substr(date, 1, 4)
    src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                   year, date)
    dest <- file.path("data", basename(src))
    if(!file.exists(dest)) {
        val <- download.file(src, dest, quiet = TRUE)
        if(!val)
            stop("unable to download file ", src)
    }
    dest
}

check_pkg_deps <- function() {
    if(!require(readr)) {
        message("installing the 'readr' package")
        install.packages("readr")
    }
    if(!require(dplyr))
        stop("the 'dplyr' package needs to be installed first")
}


num_download <- function(pkgname, date = "2016-07-20") {
    check_pkg_deps()
    dest <- check_for_logfile(date)
    cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
    cran %>% filter(package == pkgname) %>% nrow
}

# Vectorization (argument is a vector, not only a single value)

## 'pkgname' can now be a character vector of names
num_download <- function(pkgname, date = "2016-07-20") {
    check_pkg_deps()
    dest <- check_for_logfile(date)
    cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
    cran %>% filter(package %in% pkgname) %>% 
        group_by(package) %>%
        summarize(n = n())
}    

# Argument Checking

num_download <- function(pkgname, date = "2016-07-20") {
    check_pkg_deps()
    
    ## Check arguments
    if(!is.character(pkgname))
        stop("'pkgname' should be character")
    if(!is.character(date))
        stop("'date' should be character")
    if(length(date) != 1)
        stop("'date' should be length 1")
    
    dest <- check_for_logfile(date)
    cran <- read_csv(dest, col_types = "ccicccccci", 
                     progress = FALSE)
    cran %>% filter(package %in% pkgname) %>% 
        group_by(package) %>%
        summarize(n = n())
}    


# home work ----
install.packages("swirl")
library(swirl)
install_course("Advanced R Programming")
swirl()





# Write your own binary operator below from absolute scratch! Your binary
# operator must be called %p% so that the expression:
#
#       "Good" %p% "job!"
#
# will evaluate to: "Good job!"

"%p%" <- function(left, right){ # Remember to add arguments!
    paste(left, right)
}


mad_libs <- function(...){
    # Do your argument unpacking here!
    args <- list(...)
    place <- args[["place"]]
    adjective <- args[["adjective"]]
    noun <- args[["noun"]]
    # Don't modify any code below this comment.
    # Notice the variables you'll need to create in order for the code below to
    # be functional!
    paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}

evaluate <- function(func, dat){
    # Write your code here!
    # Remember: the last expression evaluated will be returned! 
    func(dat)
}



