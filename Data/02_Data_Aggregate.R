rm(list=ls())

#Libraries
library(tidyverse)

#Read RDS
AllData=readRDS(file="~/Documents/NOAA_Data/All.NOAA.Data.RDS")

#Failsafe
REDO=FALSE

#Numeric Values
NumericCol=c("Elevation", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
             "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
             "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
             "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
             "Precipitation.Amount.Inches", "Snow.Depth.Inches")

#Extract day and month and average all data across three years per day.
AllData$DayMonth=format(as.Date(AllData$Date, format="%d/%m/%Y"),"%m-%d")

if(REDO==TRUE){
  #Test if the result is three values per location, as the aggregate function does take date with year into account
  TestData=aggregate(x=AllData[,NumericCol], by=list(AllData$Location.Name, AllData$Date), FUN=mean)
  
  #Save data
  write_delim(x=TestData, path="F:/NOAA/TestData.txt", delim="\t")
}

#Aggregate data per location and date (equal dates across all three years)
MeanData=aggregate(x=AllData[,NumericCol], by=list(AllData$Location.Name, AllData$DayMonth), FUN=mean)

#Save data
saveRDS(object=MeanData, file="~/Aggregated.NOAA.Data.RDS.gzip", compress="bzip2")

