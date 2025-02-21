rm(list=ls(all=TRUE))
library(lubridate)
library(tidyr)
library(tibble)
library(pracma)

path = "/data/"
xy.coord = readRDS("xy_coord_AK.rds")

day.wc.hist <- readRDS(paste0(path, "Res03_ndays_wc_hist.RDS"))
day.wc.pgw  <- readRDS(paste0(path, "Res03_ndays_wc_pgw.RDS"))

## Make data for circular 
day <- c(1:365)
deg.day <- (day/365) * 360
rad.day <- deg2rad(deg.day)

## Historical
data.hist <- list() 
for(igr in 1:nrow(xy.coord)){
  cat('\r',igr,'/',nrow(xy.coord))
  cdata.all <- NULL
  for(i in c(1:length(day))){
    if(as.numeric(day.wc.hist[igr,][i]) == 0) next
    cdata <- data.frame(val=rep(rad.day[i], round(as.numeric(day.wc.hist[igr,][i]),digits=0)))
    cdata.all <- rbind(cdata.all, cdata)
  }
  data.hist[[igr]] <- cdata.all
}
saveRDS(data.hist, paste0(path, "Res04_cdata_total_wc_days_hist.RDS"))

## PGW
data.pgw <- list() 
for(igr in 1:nrow(xy.coord)){
  cat('\r',igr,'/',nrow(xy.coord))
  cdata.all <- NULL
  for(i in c(1:length(day))){
    if(as.numeric(day.wc.pgw[igr,][i]) == 0) next
    cdata <- data.frame(val=rep(rad.day[i], round(as.numeric(day.wc.pgw[igr,][i]),digits=0)))
    cdata.all <- rbind(cdata.all, cdata)
  }
  data.pgw[[igr]] <- cdata.all
}
saveRDS(data.pgw, paste0(path, "Res04_cdata_total_wc_days_pgw.RDS"))

#####################
# End
#####################
