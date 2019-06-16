rm(list=ls())

#Libraries
library(tidyverse)
library(plyr)

#Cleaning the data


#List files
TextFiles=list.files(path="F:/NOAA/", full.names=TRUE, pattern="\\.txt")

#Numeric Values
NumericCol=c("Elevation", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
  "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
  "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
  "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
  "Precipitation.Amount.Inches", "Snow.Depth.Inches")

#Load data
AllFiles=lapply(TextFiles, function(i){
  temp=read_delim(file=i, delim="\t")
  temp=na.omit(temp)
  
  #Fix stupid colnames
  colnames(temp)=c("Station","Date","Latitude","Longitude",
                   "Elevation", "Location.Name", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
                   "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
                   "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
                   "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
                   "Precipitation.Amount.Inches", "Snow.Depth.Inches", "NN2")
  
  #Change some class
  temp[,NumericCol] = apply(temp[,NumericCol], 2, function(x) as.numeric(x))
  
  
  temp
  
})

#Turn into one table
AllData=as.tibble(ldply(.data=AllFiles, .fun=data.frame))

#Save RDS
saveRDS(object=AllData, file="F:/NOAA/All.NOAA.Data.RDS", compress=TRUE)

