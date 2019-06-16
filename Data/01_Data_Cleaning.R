rm(list=ls())

#Libraries
library(tidyverse)
library(plyr)

#Cleaning the data


#List files
TextFiles=list.files(path="F:/NOAA/", full.names=TRUE)

#Load data
AllFiles=lapply(TextFiles, function(x){
  read_delim(file=x, delim="\t")
  })

#Turn into one table
AllData=as.tibble(ldply(.data=AllFiles, .fun=data.frame))

#Fix stupid colnames
colnames(AllData)=c("Station","Date","Latitude","Longitude",
                     "Elevation", "NN1", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
                     "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
                     "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
                     "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
                     "Precipitation.Amount.Inches", "Snow.Depth.Inches", "NN2")
AllData=AllData[colnames(AllData)[!grepl(pattern="NN", x=colnames(AllData))]]

#Delete NA
AllData=na.omit(AllData)

#Save RDS
saveRDS(object=AllData, file="F:/NOAA/All.NOAA.Data.RDS", compress=TRUE)

