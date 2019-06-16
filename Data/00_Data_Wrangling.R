#Download and transform data from NOAA
#Raw data should be deleted afterwards as is too heavy for a git repo

#Library
library(tidyverse)
library(plyr)
#Link
NOAAFTP="https://www.ncei.noaa.gov/data/global-summary-of-the-day/archive/"

#A small failsafe
REDO=FALSE

#Create links of the years to analyze. Between 3 to 5 years. 3 to start.
LinksToDownload=paste0(NOAAFTP,2018:(2018-2),".tar.gz")

if(REDO==TRUE){
  #Throw this to system
  for(i in 1:length(LinksToDownload)){
    system(paste0("wget ", LinksToDownload[i], " -P ", "~/GithubProjects/Shiny/NOAA-Cities-Temperature-Shiny/Data/"), 
           intern=FALSE, wait=FALSE, ignore.stdout=TRUE, ignore.stderr=TRUE)
  }
}

Years=2018:(2018-2)
for(i in 1:Years){
  i=1
  #List Files and read all files per folder
  TempList=list.files(path=paste0("~/GithubProjects/Shiny/NOAA-Cities-Temperature-Shiny/Data/", Years[i]), 
                      pattern="\\.csv", full.names=TRUE)
  
  #Load Data
  YearTemp=lapply(TempList, function(x){
    temp=suppressMessages(read_delim(file=x, delim=",", progress=FALSE))
    temp=temp[colnames(temp)[!grepl(pattern="_ATTRIBUTES", x=colnames(temp))]]
  })
  
  YearTemp=ldply(.data=YearTemp, .fun=as.tibble)
  ncol(YearTemp)
  colnames(YearTemp)
  
  #Fix stupid colnames
  # colnames(YearTemp)=c("Station","Date","Latitude","Longitude",
  #                      "Elevation", "NN1", "Mean.Temperature.Fahrenheit", "Mean.Dew.Point.Fahrenheit",
  #                      "Mean.Sea.Level.Pressure.Millibars","Mean.Station.Pressure.Millibars",
  #                      "Mean.Visibility.Miles", "Mean.Wind.Speed.Knots", "Maximum.Sustained.Wind.Speed.Knots",
  #                      "Maximum.Wind.Gust.Knots","Maximum.Temperature.Fahrenheit","Minimum.Temperature.Fahrenheit",
  #                      "Precipitation.Amount.Inches", "Snow.Depth.Inches", "NN2")
  
  #YearTemp=YearTemp[colnames(YearTemp)[!grepl(pattern="NN", x=colnames(YearTemp))]]
  
  #Save
  write_delim(x=YearTemp, 
              path=paste0(getwd(), "/Data/", Years[i],".txt"), 
              delim="\t")
  
}


