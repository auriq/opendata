# assumes RESS, timeDate, TTR packages have already been installed
# if these have not been installed, run install.packages("RESS"), install.packages("timeDate"), install.packages("TTR")
library(RESS)
library(timeDate)
library(TTR)
setwd("~/essentia-scripts/sh")
mydata <- read.essentia("fb.sh")
tradevol <- mydata$tradevol
date.sequence <- timeSequence(as.Date("2013-01-01"), ("2013-12-31"))
holidays <- holidayNYSE(2013)
# construct date sequence of NYSE's working days
business.days <- date.sequence[isBizday(date.sequence, holidays)]
plot(business.days, tradevol, type="o", col="black", xlab="date", ylab="trade volume")
par(ask=TRUE)
# smooth time series using simple moving average (SMA) of order 3
fbtimeseries <- SMA(tradevol, n=3)
plot.ts(fbtimeseries)

