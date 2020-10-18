
# HW4
# Part 1
# factorial 
# Factorial_loop: a version that computes the factorial of an integer using looping (such as a for loop)
factorial_loop <- function(n) {
    if (n < 0 ) {stop("n should be greater than 0")
        } else if (n == 0) {
    result <- 1
    } else {
    for(i in 1:n){
        result <- result*i
    }
    }
   
     result

}

# Factorial_reduce: a version that computes the factorial using the reduce() function in the purrr package. Alternatively, you can use the Reduce() function in the base package.

factorial_reduce <- function(n){
    n <- as.integer(n)
    Reduce("*",1:n)
}


# Factorial_func: a version that uses recursion to compute the factorial.
factorial_rec <- function(n){
    if (n < 0 ) {stop("n should be greater than 0")}
    if(n == 0){
        1
    } else {
        n*factorial_rec(n-1)
    }
}


# Factorial_mem: a version that uses memoization to compute the factorial.
factorial_tbl <- c(1, 2, rep(NA, 10))

factorial_mem <- function(n){
    stopifnot(n > 0)
    
    if(!is.na(factorial_tbl[n])){
        factorial_tbl[n]
    } else {
        factorial_tbl[n - 1] <<- factorial_mem(n - 1)
        factorial_tbl[n] <<- factorial_tbl[n - 1]*n
        factorial_tbl[n]
        
    }
}

# timing these four functions ---
library(purrr)
library(microbenchmark)
library(tidyr)
library(magrittr)
library(dplyr)
library(ggpubr)


evaluate.time <- function(f, n) {
    data <- map(1:n, function(x){microbenchmark(f(x))$time})
    names(data) <- paste0(letters[1:n], 1:n)
    data <- as.data.frame(data)
    
    data %<>%
        gather(num, time) %>%
        group_by(num) %>%
        summarise(med_time = median(time))
    return(data)
    
}


loop.time <- evaluate.time(factorial_loop,10)
reduce.time <- evaluate.time(factorial_loop,10)
rec.time<- evaluate.time(factorial_rec,10)
memo.time <- evaluate.time(factorial_mem,10)

time.plot <- data.table::rbindlist(list(loop.time,reduce.time,rec.time,memo.time))
time.plot$fs <- rep(c("loop", "reduce","recursion","memo"),each = 10)

write.table(time.plot, "factorial_output.txt", col.names = TRUE, row.names = FALSE,
            sep = "\t", quote = FALSE)

# scatter plot to compare four methods' performing time vs n 

sp <- ggscatter(time.plot, x = "num", y = "med_time",
                add = "reg.line",               
                conf.int = TRUE,                
                color = "fs", palette = "jco", 
                shape = "fs"                   
)

sp


