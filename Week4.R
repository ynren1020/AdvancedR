# Object - Oriented Programming

# S3

# In the S3 system you can arbitrarily assign a class to any object, 
# which goes against most of what we discussed in the Object Oriented 
# Principles section. Class assignments can be made using the structure() function, 
# or you can assign the class using class()and <-:
    
special_num_1 <- structure(1, class = "special_number")
class(special_num_1)
# [1] "special_number"

special_num_2 <- 2
class(special_num_2)
# [1] "numeric"
class(special_num_2) <- "special_number"
class(special_num_2)
# [1] "special_number"


shape_s3 <- function(side_lengths){
    structure(list(side_lengths = side_lengths), class = "shape_S3")
}

square_4 <- shape_s3(c(4, 4, 4, 4))
class(square_4)
#[1] "shape_S3"

triangle_3 <- shape_s3(c(3, 3, 3))
class(triangle_3)
#[1] "shape_S3"

# A generic method can return different values based depending on the class of 
# its input. For examplemean() is a generic method that can find the average of 
# a vector of number or it can find the “average day” from a vector of dates.


mean(c(2, 3, 7))
# [1] 4
mean(c(as.Date("2016-09-01"), as.Date("2016-09-03")))
# [1] "2016-09-02"

# Now let’s create a generic method for identifying shape_S3 objects that are squares. 
# The creation of every generic method uses the UseMethod() function in the following way 
# with only slight variations:

[name of method] <- function(x) UseMethod("[name of method]")
is_square <- function(x) UseMethod("is_square")

#Now we can add the actual function definition for detecting whether or not a shape 
#is a square by specifying is_square.shape_S3. By putting a dot (.) and then 
#the name of the class after is_squre, we can create a method that associates 
#is_squre with the shape_S3class:

is_square.shape_S3 <- function(x){
    length(x$side_lengths) == 4 &&
        x$side_lengths[1] == x$side_lengths[2] &&
        x$side_lengths[2] == x$side_lengths[3] &&
        x$side_lengths[3] == x$side_lengths[4]
}

is_square(square_4)
# [1] TRUE
is_square(triangle_3)
# [1] FALSE

#Seems to be working well! We also want is_square() to return NA 
#when its argument is not a shape_S3. We can specifyis_square.default 
#as a last resort if there is not method associated with the object passed to is_square().

is_square.default <- function(x){
    NA
}

is_square("square")
#[1] NA
is_square(c(1, 1, 1, 1))
#[1] NA

print(square_4)
#$side_lengths
#[1] 4 4 4 4

attr(,"class")
#[1] "shape_S3"

# Lucky for us print() is a generic method, so we can specify a print method 
# for the shape_S3 class:


print.shape_S3 <- function(x){
    if(length(x$side_lengths) == 3){
        paste("A triangle with side lengths of", x$side_lengths[1], 
              x$side_lengths[2], "and", x$side_lengths[3])
    } else if(length(x$side_lengths) == 4) {
        if(is_square(x)){
            paste("A square with four sides of length", x$side_lengths[1])
        } else {
            paste("A quadrilateral with side lengths of", x$side_lengths[1],
                  x$side_lengths[2], x$side_lengths[3], "and", x$side_lengths[4])
        }
    } else {
        paste("A shape with", length(x$side_lengths), "slides.")
    }
}

print(square_4)
#[1] "A square with four sides of length 4"
print(triangle_3)
#[1] "A triangle with side lengths of 3 3 and 3"
print(shape_s3(c(10, 10, 20, 20, 15)))
#[1] "A shape with 5 slides."
print(shape_s3(c(2, 3, 4, 5)))
#[1] "A quadrilateral with side lengths of 2 3 4 and 5"


#Since printing an object to the console is one of the most common things to do in R, 
#nearly every class has an assocaited print method! To see all of the methods 
#associated with a generic like print() use the methods() function:

head(methods(print), 10)
#[1] "print,ANY-method"            "print,diagonalMatrix-method"
#[3] "print,sparseMatrix-method"   "print.acf"                  
#[5] "print.AES"                   "print.anova"                
#[7] "print.anova.gam"             "print.anova.lme"            
#[9] "print.aov"                   "print.aovlist" 

#One last note on S3 with regard to inheritance. In the previous section 
#we discussed how a sub-class can inherit attributes and methods from a super-class. 
#Since you can assign any class to an object in S3, you can specify a super class 
#for an object the same way you would specify a class for an object:
    
class(square_4)
#[1] "shape_S3"
class(square_4) <- c("shape_S3", "square")
class(square_4)
#[1] "shape_S3" "square" 

#To check if an object is a sub-class of a specified class you can use the inherits() function:
inherits(square_4, "square")
#[1] TRUE

# S4 --------------------
# To create a new class in S4 you need to use the setClass() function. 
# You need to specify two or three arguments for this function: 
# Class which is the name of the class as a string,slots, 
# which is a named list of attributes for the class with the class 
# of those attributes specified, and optionally contains which includes 
# the super-class of they class you’re specifying (if there is a super-class). 
# Take look at the class definition for a bus_S4 and aparty_bus_S4 below:

setClass("bus_S4",
         slots = list(n_seats = "numeric", 
                      top_speed = "numeric",
                      current_speed = "numeric",
                      brand = "character"))
setClass("party_bus_S4",
         slots = list(n_subwoofers = "numeric",
                      smoke_machine_on = "logical"),
         contains = "bus_S4")

#Now that we’ve created the bus_S4 and the party_bus_S4 classes 
#we can create bus objects using the new() function. 
#The new() function’s arguments are the name of the class and 
#values for each “slot” in our S4 object.

my_bus <- new("bus_S4", n_seats = 20, top_speed = 80, 
              current_speed = 0, brand = "Volvo")
my_bus

my_party_bus <- new("party_bus_S4", n_seats = 10, top_speed = 100,
                    current_speed = 0, brand = "Mercedes-Benz", 
                    n_subwoofers = 2, smoke_machine_on = FALSE)
my_party_bus

# You can use the @ operator to access the slots of an S4 object:
my_bus@n_seats
# [1] 20
my_party_bus@top_speed
# [1] 100

# This is essentially the same as using the $ operator with a list or an environment.

#S4 classes use a generic method system that is similar to S3 classes. 
# In order to implement a new generic method you need to use the setGeneric() 
# function and the standardGeneric() function in the following way:

setGeneric("new_generic", function(x){
    standardGeneric("new_generic")
})

# Let’s create a generic function called is_bus_moving() to see if a bus_S4 object is in motion:

setGeneric("is_bus_moving", function(x){
    standardGeneric("is_bus_moving")
})
# [1] "is_bus_moving"


# Now we need to actually define the function which we can to withsetMethod(). 
# The setMethod() functions takes as arguments the name of the method as a string, 
# the method signature which specifies the class of each argument for the method, 
# and then the function definition of the method:

setMethod("is_bus_moving",
          c(x = "bus_S4"),
          function(x){
              x@current_speed > 0
          })
# [1] "is_bus_moving"

is_bus_moving(my_bus)
# [1] FALSE
my_bus@current_speed <- 1
is_bus_moving(my_bus)
# [1] TRUE

# In addition to creating your own generic methods, you can also create a method 
# for your new class from an existing generic. First use thesetGeneric() function 
# with the name of the existing method you want to use with your class, 
# and then use the setMethod() function like in the previous example. 
# Let’s make a print() method for the bus_S4 class:

setGeneric("print")
# [1] "print"

setMethod("print",
          c(x = "bus_S4"),
          function(x){
              paste("This", x@brand, "bus is traveling at a speed of", x@current_speed)
          })
# [1] "print"

print(my_bus)
# [1] "This Volvo bus is traveling at a speed of 1"
print(my_party_bus)
# [1] "This Mercedes-Benz bus is traveling at a speed of 0"


# Reference Classes
# With reference classes we leave the world of R’s old object oriented 
# systems and enter the philosophies of other prominent object oriented 
# programming languages. We can use the setRefClass() function to define 
# a class’ fields, methods, and super-classes. Let’s make a reference class
# that represents a student:
Student <- setRefClass("Student",
                       fields = list(name = "character",
                                     grad_year = "numeric",
                                     credits = "numeric",
                                     id = "character",
                                     courses = "list"),
                       methods = list(
                           hello = function(){
                               paste("Hi! My name is", name)
                           },
                           add_credits = function(n){
                               credits <<- credits + n
                           },
                           get_email = function(){
                               paste0(id, "@jhu.edu")
                           }
                       ))

# To recap: we’ve created a class definition called Student which defines 
# the student class. This class has five fields and three methods. 
# To create a Student object use the new() method:
brooke <- Student$new(name = "Brooke", grad_year = 2019, credits = 40,
                      id = "ba123", courses = list("Ecology", "Calculus III"))
roger <- Student$new(name = "Roger", grad_year = 2020, credits = 10,
                     id = "rp456", courses = list("Puppetry", "Elementary Algebra"))

# You can access the fields and methods of each object using the $operator:
brooke$credits
# [1] 40
roger$hello()
# [1] "Hi! My name is Roger"
roger$get_email()
# [1] "rp456@jhu.edu"

# Methods can change the state of an object, for instance in the case of the add_credits() function:
brooke$credits
# [1] 40
brooke$add_credits(4)
brooke$credits
# [1] 44

# Notice that the add_credits() method uses the complex assignment operator (<<-). 
# You need to use this operator if you want to modify one of the fields of an object 
# with a method. You’ll learn more about this operator in the Expressions & Environments
# section.

# Reference classes can inherit from other classes by specifying the contains 
# argument when they’re defined. Let’s create a sub-class of Student called 
# Grad_Student which includes a few extra features:

Grad_Student <- setRefClass("Grad_Student",
                            contains = "Student",
                            fields = list(thesis_topic = "character"),
                            methods = list(
                                defend = function(){
                                    paste0(thesis_topic, ". QED.")
                                }
                            ))

jeff <- Grad_Student$new(name = "Jeff", grad_year = 2021, credits = 8,
                         id = "jl55", courses = list("Fitbit Repair", 
                                                     "Advanced Base Graphics"),
                         thesis_topic = "Batch Effects")

jeff$defend()
# [1] "Batch Effects. QED."

#R has three object oriented systems: S3, S4, and Reference Classes.
#Reference Classes are the most similar to classes and objects in other programming languages.
#Classes are blueprints for an object.
#Objects are individual instances of a class.
#Methods are functions that are associated with a particular class.
#Constructors are methods that create objects.
#Everything in R is an object.
#S3 is a liberal object oriented system that allows you to assign a class to any object.
#S4 is a more strict object oriented system that build upon ideas in S3.
#Reference Classes are a modern object oriented system that is similar to Java, C++, Python, or Ruby.






