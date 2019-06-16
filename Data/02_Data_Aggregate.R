rm(list=ls())

#Libraries
library(tidyverse)

#Read RDS
AllData=readRDS(file="F:/NOAA/All.NOAA.Data.RDS")

#Extract day and month and average all data across three years per day.
AllData$DayMonth=format(as.Date(AllData$Date, format="%d/%m/%Y"),"%m-%d")

TEMP=head(AllData)
TEMP$Latitude
TEMP$Longitude
TEMP2=AllData[AllData$DayMonth==format(as.Date("06-23", format="%m-%d"),"%m-%d"),]
unique(TEMP2$Date)
aggregate(x=TEMP, by=list(TEMP$DayMonth), FUN=mean)
