
# Load libraries ---------------------------------------------------------------
library(dplyr)
library(tidyr)

longdf <- read.csv("./data/MIE.csv", stringsAsFactors = FALSE)
# Define generic functions -----------------------------------------------------
subject <- function(ld_df, id) UseMethod("subject")

visit <- function(subject, visit_numb) UseMethod("visit")

room <- function(visit, room_name) UseMethod("room")



# Define methods for LongitudionalData objects ---------------------------------
make_LD <- function(df) {
    ld_df <- as.data.frame(df)
    class(ld_df) <- "LongitudinalData"
    ld_df
}

print.LongitudinalData <- function(x, ...) {
    cat("Longitudinal dataset with", length(unique(x$id)), " subjects\n")
    invisible(x)
}


subject.LongitudinalData <- function(ld_df, id) {
    
    if (!(id%in%ld_df$id))
        return(NULL)
    ld_df.sub <- data.frame(id = ld_df$id[ld_df$id==id], 
                            visit = ld_df$visit[ld_df$id==id],
                            room = ld_df$room[ld_df$id==id],
                            value = ld_df$value[ld_df$id==id],
                            timepoint = ld_df$timepoint[ld_df$id==id])
    structure(list(id = id, data = ld_df.sub), class = "Subject")
}


# Define methods for Subject objects -------------------------------------------
print.Subject <- function(x) {
    cat("Subject ID: ", x[["id"]], "\n")
    invisible(x)
    
}

summary.Subject <- function(subject) {
    
    output <- subject$data %>% 
        group_by(visit, room) %>%
        summarise(value = mean(value)) %>% 
        spread(room, value) %>% 
        as.data.frame
    structure(list(id = subject$id,
                   data = output), class = "summary_Subject")
}

visit.Subject <- function(subject, visit_num ) {
    visit.sub <- subject$data
    visit.sub <- visit.sub[visit.sub$visit==visit_num, ]
    structure(list(id = visit.sub$id,
                   visit_num = visit_num,
                   data = visit.sub), class = "visit")
}


# Define methods for Visit objects ---------------------------------------------
room.visit <- function(visit, room_name) {
     room.sub <- visit$data
     room.sub <- room.sub[room.sub$room==room_name, ]
    structure(list(id = room.sub$id,
                   visit = room.sub$visit,
                   room = room_name,
                   data = room.sub), class = "room")
}

# Define methods for Room objects ----------------------------------------------
print.room <- function(x) {
    cat("ID:", unique(x$id), "\n")
    cat("Visit:", unique(x$visit), "\n")
    cat("Room:", x$room, "\n")
    invisible(x)
    
}

summary.room <- function(object) {
    object.sub <- object$data
    output <- summary(object.sub$value)
    structure(list(id = object$id,
                   visit = object$visit,
                   room = object$room,
                   data = output), class = "summary_room")
}

# Define methods for Summary objects -------------------------------------------
print.summary_room <- function(x) {
    cat("ID:", unique(x$id), "\n")
    cat("Visit:", unique(x$visit), "\n")
    cat("Room:", unique(x$room), "\n")
    print(x$data)
    invisible(x)
}




# output --------------
x <- make_LD(longdf)
print(class(x))
print(x)

out <- subject(x, 10)
print(out)

out <- subject(x, 14)
print(out)

out <- subject(x, 54) %>% summary
print(out)

out <- subject(x, 14) %>% summary
print(out)

out <- subject(x, 44) %>% visit(0) %>% room("bedroom")
print(out)

out <- subject(x, 44) %>% visit(1) %>% room("living room") %>% summary
print(out)

