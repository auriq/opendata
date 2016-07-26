# assumes RESS package has already been installed
# if this has not been installed, run install.packages("RESS")
library(RESS)
setwd("~/essentia-scripts/sh")
mydata <- read.essentia("border.sh")
summary(mydata)
year <- mydata$year
count <- mydata$Count
plot(year, count)
reg1 <- lm(count ~ year)
par(ask=TRUE)
plot(reg1)
graph <- mydata[order(mydata[,1]),]
barplot(t(as.matrix(graph[,2])), names.arg=graph[,1], col=c("black"), beside=TRUE, main="Border Crossings by Year: Mexico",xlab="Year",axes=TRUE,las=2)
