# use quote() to create an expression
two_plus_two <- quote(2 + 2)
two_plus_two
#2 + 2
eval(two_plus_two) 
#[1] 4

# string to expression using parse
tpt_string <- "2 + 2"
tpt_expression <- parse(text = tpt_string)
eval(tpt_expression)
#[1] 4

# expression to string by deparse
deparse(two_plus_two)
#[1] "2 + 2"

#One interesting feature about expressions is that you can access and modify their 
#contents like you a list(). This means that you can change the values in an expression,
#or even the function being executed in the expression before it is evaluated:
sum_expr <- quote(sum(1, 5))
eval(sum_expr)
#[1] 6
sum_expr[[1]]
sum
sum_expr[[2]]
#[1] 1
sum_expr[[3]]
#[1] 5
sum_expr[[1]] <- quote(paste0)
sum_expr[[2]] <- quote(4)
sum_expr[[3]] <- quote(6)
eval(sum_expr)
#[1] "46"


sum_40_50_expr <- call("sum", 40, 50)
sum_40_50_expr
sum(40, 50)
eval(sum_40_50_expr)
#[1] 90


return_expression <- function(...){
    match.call()
}

return_expression(2, col = "blue", FALSE)
#return_expression(2, col = "blue", FALSE)


first_arg <- function(...){
    expr <- match.call()
    first_arg_expr <- expr[[2]]
    first_arg <- eval(first_arg_expr)
    if(is.numeric(first_arg)){
        paste("The first argument is", first_arg)
    } else {
        "The first argument is not numeric."
    }
}

first_arg(2, 4, "seven", FALSE)
#[1] "The first argument is 2"

first_arg("two", 4, "seven", FALSE)
#[1] "The first argument is not numeric."
    
    