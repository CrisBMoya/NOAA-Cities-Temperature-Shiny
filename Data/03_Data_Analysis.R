rm(list=ls())

#Libraries
library(tidyverse)

#Read RDS
AggregatedDF=readRDS(file=paste0(getwd(),"/Data/Aggregated.NOAA.Data.RDS.bzip2"))
AggregatedDF=as.tibble(AggregatedDF)
AggregatedDF$Group.1[1]

temp=AggregatedDF[AggregatedDF$Group.1==AggregatedDF$Group.1[1],]
temp$Group.2
