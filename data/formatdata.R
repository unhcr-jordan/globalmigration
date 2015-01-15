mov <- read.csv("originaldata.csv")

show2 <- read.csv("region.csv", dec=",")

mov1 <- merge (x=mov, y=show2, by.x="gov_orig", by.y="name") 
mov1 <- merge (x=mov1, y=show2, by.x="gov_dest", by.y="name") 

#gov_dest  gov_orig	gov_orig_id	gov_id	flow	metadata	
#region.x	regionid.x	iso.x	show..1...yes..0...no..x	
#region.y	regionid.y	iso.y	show..1...yes..0...no..y

# originregion_id,originregion_name,destinationregion_id,destinationregion_name,regionflow_1990,regionflow_1995,regionflow_2000,regionflow_2005,xxx,
#origin_iso,origin_name,destination_iso,destination_name,countryflow_1990,countryflow_1995,countryflow_2000,countryflow_2005,origin_show,destination_show

move <- mov1[, c(
  "regionid.x",  "regionid.y", "region.x",   "region.y",    "gov_orig_id",  "gov_dest",   "gov_id", "gov_orig", "flow"  
  )] 

################
#install.packages("plyr")
library(plyr)

move <- rename(move, c( "region.x"="originregion_name",  "regionid.x"="originregion_id",  "region.y"="destinationregion_name", 
                          "regionid.y"="destinationregion_id", "gov_dest"="destination_name",  "gov_orig"="origin_name",  "gov_orig_id"="origin_iso",
                          "gov_id"="destination_iso",  "flow"="countryflow_1990" ))

aggregated <- aggregate(cbind(countryflow_1990 ) ~ originregion_name + destinationregion_name,  data = move, FUN = sum, na.rm = TRUE)

aggregated <- rename(aggregated, c( "countryflow_1990"="regionflow_1990" ))


move2 <- merge(x=move, y=aggregated, by=c("originregion_name","destinationregion_name"))

#move2 <- rename(move, c( "countryflow_1990.x"= "countryflow_1990", "countryflow_1990.y"= "regionflow_1990" ))

move2$regionflow_1995 <- move2$regionflow_1990
move2$regionflow_2000 <- move2$regionflow_1990
move2$regionflow_2005 <- move2$regionflow_1990

move2$countryflow_1995 <- move2$countryflow_1990
move2$countryflow_2000 <- move2$countryflow_1990
move2$countryflow_2005 <- move2$countryflow_1990

move2$xxx <- ""
move2$origin_show <- "1"
move2$destination_show <- "1"


# originregion_id  originregion_name	destinationregion_id	destinationregion_name	regionflow_1990	regionflow_1995	regionflow_2000	regionflow_2005
#xxx	
#origin_iso	origin_name	destination_iso	destination_name	countryflow_1990	countryflow_1995	countryflow_2000	countryflow_2005
# origin_show	destination_show

move3 <- move2[, c(
  "originregion_id","originregion_name", "destinationregion_id" , "destinationregion_name" ,  "regionflow_1990", "regionflow_1995", "regionflow_2000", "regionflow_2005", 
  "xxx",
  "origin_iso", "origin_name","destination_iso", "destination_name", "countryflow_1990","countryflow_1995", "countryflow_2000", "countryflow_2005", 
  "origin_show", "destination_show" 
)] 


move3$origin_iso <- toupper(substr(move3$origin_name, 1,3))
move3$destination_iso <-  toupper(substr(move3$destination_name, 1,3))

write.csv(move3, file="data1.csv",row.names=F, na="")

