# assumes RESS, reshape packages have already been installed
# if these have not been installed, run install.packages("RESS") and install.packages("reshape")
library(RESS)
library(reshape)
setwd("~/essentia-scripts/sh")
mydata <- read.essentia("pop_estimates.sh")
names(mydata) <- c("location", "pop2010", "pop2011", "pop2012", "pop2013", "pop2014", "pop2015")
regiondata <- head(mydata,4)
region <- regiondata$region
population <- regiondata$pop2015
# construct bar graph of 2015 population by region
barplot(t(as.matrix(population)), names.arg = regiondata[,1], col="black", cex.names=0.7, cex.axis=0.7, main="US Population in 2015 by Region")
# show population in west region by year
# extract "west region" row, then melt to reshape into columns of data
west <- regiondata[2,]
west <- melt(west)
year <- c(2010:2015)
population <- west$value
lp <- plot(year, population, cex.axis=0.75, main="Population of US West Region 2010-2015")
fit <- lsfit(year,population)
abline(fit)