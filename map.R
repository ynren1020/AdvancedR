# -----------
library(purrr)

map_chr(c(5, 4, 3, 2, 1), function(x){
    c("one", "two", "three", "four", "five")[x]
})
[1] "five"  "four"  "three" "two"   "one"  

map_lgl(c(1, 2, 3, 4, 5), function(x){
    x > 3
})
[1] FALSE FALSE FALSE  TRUE  TRUE


#The map_if() function takes as its arguments a list or vector containing data, 
#a predicate function, and then a function to be applied. A predicate function is
#a function that returns TRUE orFALSE for each element in the provided list or vector. 
#In the case ofmap_if(): if the predicate functions evaluates to TRUE, then the function 
#is applied to the corresponding vector element, however if the predicate function evaluates 
#to FALSE then the function is not applied. The map_if() function always returns a list, 
#so I’m piping the result of map_if() to unlist() so it look prettier:


map_if(1:5, function(x){
    x %% 2 == 0
},
function(y){
    y^2
}) %>% unlist()
[1]  1  4  3 16  5


#The map_at() function only applies the provided function to elements of a vector specified by their indexes. map_at() always returns a list so like before I’m piping the result to unlist():
map_at(seq(100, 500, 100), c(1, 3, 5), function(x){
    x - 10
}) %>% unlist()
#[1]  90 200 290 400 490


map2_chr(letters, 1:26, paste)
#[1] "a 1"  "b 2"  "c 3"  "d 4"  "e 5"  "f 6"  "g 7"  "h 8"  "i 9"  "j 10"
#[11] "k 11" "l 12" "m 13" "n 14" "o 15" "p 16" "q 17" "r 18" "s 19" "t 20"
#[21] "u 21" "v 22" "w 23" "x 24" "y 25" "z 26"


pmap_chr(list(
    list(1, 2, 3),
    list("one", "two", "three"),
    list("uno", "dos", "tres")
), paste)
#[1] "1 one uno"    "2 two dos"    "3 three tres"


# Search (contains or detect or detect_index function)
contains(letters, "a")
#[1] TRUE
contains(letters, "A")
#[1] FALSE

detect(20:40, function(x){
    x > 22 && x %% 2 == 0
})
#[1] 24

detect_index(20:40, function(x){
    x > 22 && x %% 2 == 0
})
#[1] 5


# Filter functions (keep, discard, every, some), the second arg is predicate function
keep(1:20, function(x){
    x %% 2 == 0
})
#[1]  2  4  6  8 10 12 14 16 18 20

discard(1:20, function(x){
    x %% 2 == 0
})
#[1]  1  3  5  7  9 11 13 15 17 19

every(1:20, function(x){
    x %% 2 == 0
})

some(1:20, function(x){
    x %% 2 == 0
})


# Compose (combine any numbers of functions into one)

n_unique <- compose(length, unique)
# The composition above is the same as:
# n_unique <- function(x){
#   length(unique(x))
# }

rep(1:5, 1:5)
#[1] 1 2 2 3 3 3 4 4 4 4 5 5 5 5 5

n_unique(rep(1:5, 1:5))
#[1] 5

# Partial function (take part of a function's arguments, return a new function with unspecified arg)
library(purrr)

mult_three_n <- function(x, y, z){
    x * y * z
}

mult_by_15 <- partial(mult_three_n, x = 3, y = 5)

mult_by_15(z = 4)
[1] 60


# If you want to evaluate a function across a data structure you should use the walk() function from purrr. Here’s a simple example:
library(purrr)

walk(c("Friends, Romans, countrymen,",
       "lend me your ears;",
       "I come to bury Caesar,", 
       "not to praise him."), message)
#Friends, Romans, countrymen,
#lend me your ears;
#I come to bury Caesar,
#not to praise him.


# Recursion ? 


# The core functional programming concepts can be summarized in the following categories: map, reduce, search, filter, and compose.

