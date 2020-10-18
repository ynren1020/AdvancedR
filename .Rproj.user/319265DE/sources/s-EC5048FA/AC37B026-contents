

# design a class called “LongitudinalData”
setClass("LongitudinalData",
         slots = list(id = "numeric", 
                      visit = "numeric",
                      room = "character",
                      value = "numeric",
                      timepoint = "numeric"))



# design classes to represent the concept of a “subject”, a “visit”, and a “room”
setGeneric("subject", function(x, id){
    standardGeneric("subject")
})

setGeneric("visit", function(x, id, visit){
    standardGeneric("visit")
})

setGeneric("room", function(x, id, visit, room){
    standardGeneric("room")
})

# make_LD: a function that converts a data frame into a “LongitudinalData” object
make_LD <- function(longdf){
    long <- new("LongitudinalData", id = longdf$id, visit = longdf$visit, 
              room = longdf$room, value = longdf$value, timepoint = longdf$timepoint)
    long
}
# subject: a generic function for extracting subject-specific information

setMethod("subject",
          c(x = "LongitudinalData"),
          function(x, id){
              index <- x@id==id
              data.frame(subject = x@id[index], visit=x@visit[index], 
                         room = x@room[index], value = x@value[index],
                         timepoint = x@timepoint[index])
          })

# visit: a generic function for extracting visit-specific information
setMethod("visit",
          c(x = "LongitudinalData"),
          function(x, id, visit){
             index <- (x@id==id)&(x@visit==visit)
             data.frame(subject = x@id[index], visit=x@visit[index], 
                        room = x@room[index], value = x@value[index],
                        timepoint = x@timepoint[index])
          })


# room: a generic function for extracting room-specific information
setMethod("room",
          c(x = "LongitudinalData"),
          function(x, id, visit, room){
              index <- (x@id==id)&(x@visit==visit)&(x@room==room)
              data.frame(subject = x@id[index], visit=x@visit[index], 
                         room = x@room[index], value = x@value[index],
                         timepoint = x@timepoint[index])
          })


setGeneric("print")
setMethod("print",
          c(x = "LongitudinalData"),
          function(x){
              paste("This", x@id, "makes a visit of", x@visit, "at the room of", x@room)
          })


setGeneric("summary")
setMethod("summary",
          c(x = "LongitudinalData"),
          function(x){
              paste("This", x@id, "makes a visit of", x@visit, "at the room of", x@room)
          })




