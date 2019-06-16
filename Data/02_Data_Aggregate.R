rm(list=ls())

#Libraries
library(tidyverse)

#Read RDS
AllData=readRDS(file="F:/NOAA/All.NOAA.Data.RDS")

#Numeric Values
NumericCol=c("Elevation", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
             "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
             "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
             "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
             "Precipitation.Amount.Inches", "Snow.Depth.Inches")

#Extract day and month and average all data across three years per day.
AllData$DayMonth=format(as.Date(AllData$Date, format="%d/%m/%Y"),"%m-%d")

#Test if the result is three values per location, as the aggregate function does take date with year into account
TestData=aggregate(x=AllData[,NumericCol], by=list(AllData$Location.Name, AllData$Date), FUN=mean)
head(TestData)
#Aggregate data per location and date (equal dates across all three years)
MeanData=aggregate(x=AllData[,NumericCol], by=list(AllData$Location.Name, AllData$DayMonth), FUN=mean)
