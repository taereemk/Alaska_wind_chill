rm(list=ls(all=TRUE))
library(circular)
library(pracma)

path = "/data/"
xy.coord = readRDS("xy_coord_AK.rds")

day.hist <- readRDS(file=paste0(path, "Res04_cdata_total_wc_days_hist.RDS"))
day.pgw  <- readRDS(file=paste0(path, "Res04_cdata_total_wc_days_pgw.RDS"))

#Historical
cir.hist.res <- array(NA,c(nrow(xy.coord),2))
for(igr in 1:nrow(xy.coord)){
  cat('\r',igr,'/',nrow(xy.coord))
  cdata.hist <- as.numeric(day.hist[[igr]]$val)
  if(sum(cdata.hist) ==0) next
  cir.hist <- circular(cdata.hist, type = "angles", units = "radians", 
                          template = "none", zero = pi/2, rotation = "clock")
  
  cir.hist.res[igr,1] <- mean(cir.hist)
  cir.hist.res[igr,2] <- rho.circular(cir.hist)
}
colnames(cir.hist.res) <- c("mean","rho")
saveRDS(data.frame(xy.coord, cir.hist.res), paste0(path, "Res05_circular_mean_hist.RDS"))


#PGW
cir.pgw.res <- array(NA,c(nrow(xy.coord),2))
for(igr in 1:nrow(xy.coord)){
  cat('\r',igr,'/',nrow(xy.coord))
  cdata.pgw <- as.numeric(day.pgw[[igr]]$val)
  if(sum(cdata.pgw) ==0) next
  cir.pgw <- circular(cdata.pgw, type = "angles", units = "radians", 
                      template = "none", zero = pi/2, rotation = "clock")
  cir.pgw.res[igr,1] <- mean(cir.pgw)
  cir.pgw.res[igr,2] <- rho.circular(cir.pgw)
}
colnames(cir.pgw.res) <- c("mean","rho")
saveRDS(data.frame(xy.coord, cir.pgw.res), paste0(path, "Res05_circular_mean_pgw.RDS"))

