#Environments are data structures in R that have special properties with regard to their role 
#in how R code is executed and how memory in R is organized.


my_new_env <- new.env()
my_new_env$x <- 4
my_new_env$x
#[1] 4

assign("y", 9, envir = my_new_env)
get("y", envir = my_new_env)
#[1] 9
my_new_env$y
#[1] 9


ls(my_new_env)
#[1] "x" "y"
rm(y, envir = my_new_env)
exists("y", envir = my_new_env)
#[1] TRUE
exists("x", envir = my_new_env)
#[1] TRUE
my_new_env$x
#[1] 4
my_new_env$y
#NULL


# Execution Environments

x <- 10 (#global environment)

my_func <- function(){
    x <- 5
    return(x)
}

my_func() #execute environment
# [1] 5


#------------
x <- 10

another_func <- function(){
    return(x)
}

another_func()
#[1] 10


#----------
x <- 10
x
#[1] 10

assign1 <- function(){
    x <<- "Wow!"
}

assign1()
x
#[1] "Wow!"


#-----------
a_variable_name
#Error in eval(expr, envir, enclos): object 'a_variable_name' not found
exists("a_variable_name")
#[1] FALSE

assign2 <- function(){
    a_variable_name <<- "Magic!"
}

assign2()
exists("a_variable_name")
#[1] TRUE
a_variable_name
#[1] "Magic!"


# Error 
#The stop() function will generate an error.

#The stopifnot() function takes a series of logical expressions as arguments and
#if any of them are false an error is generated specifying which expression is false. 

error_if_n_is_greater_than_zero <- function(n){
    stopifnot(n <= 0)
    n
}

error_if_n_is_greater_than_zero(5)
#Error: n <= 0 is not TRUE

warning("Consider yourself warned!")
#Warning: Consider yourself warned!
    
message("In a bottle.")
#In a bottle.

# trycatch
beera <- function(expr){
    tryCatch(expr,
             error = function(e){
                 message("An error occurred:\n", e)
             },
             warning = function(w){
                 message("A warning occured:\n", w)
             },
             finally = {
                 message("Finally done!")
             })
}


is_even_error <- function(n){
    tryCatch(n %% 2 == 0,
             error = function(e){
                 FALSE
             })
}

is_even_error(714)
[1] TRUE

is_even_error("eight")
[1] FALSE



gHdvLEHvncWFAjNG





    
    

