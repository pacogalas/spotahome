install.packages("RSQLite")
install.packages("tidyverse")

library(DBI)
library(RSQLite)
con <- dbConnect(SQLite(), "exercise_final.db")

#lista de tablas
as.data.frame(dbListTables(con))
 
#leer tabla
access_log <- dbReadTable(con, 'access_log')


library(dplyr)

nrow(distinct(access_log["user_id"]))

nrow(distinct(access_log[,c("user_id", "variant")]))

access_log[duplicated(access_log[,c("user_id", "variant")]),]

duplic <- access_log[duplicated(access_log[,c("user_id", "variant")]),]

summary(access_log$variant)

#hago una primera revisión de las variables
summary(access_log)

#compruebo que el minimo de revenue es 0

user_var <- access_log[,c("user_id", "variant")]

user_var <- unique(user_var)

user_dup <- user_var[duplicated(user_var$user_id),]

table(user_var$variant)

#booking request

unique(access_log$event_type)

dup_book_req <- access_log[access_log$event_type == "booking_request",]

length(unique(dup_book_req$user_id))

dup_book_req2 <- dup_book_req[duplicated(dup_book_req$user_id),]

duplicated(user_var$user_id)


revenue <- dup_book_req[dup_book_req$revenue <= 0,]
revenue <- subset(dup_book_req, (dup_book_req$revenue <= 0) | is.na(dup_book_req$revenue))

access_log1 <- anti_join(access_log,revenue, by = c("user_id", "variant"))

dup_book_req <- access_log1[access_log1$event_type == "booking_request",]

length(unique(dup_book_req$user_id))

table(dup_book_req$variant)

unique(user_delete$user_id)
