# assumes RESS package has already been installed
# if RESS has not been installed, run install.packages("RESS")
library(RESS)
setwd("~/essentia-scripts/sh")
mydata <- read.essentia("state_taxes.sh")
summary(mydata)
state <- mydata$state
total <- mydata$total
property <- mydata$property
sales <- mydata$sales
license <- mydata$license
income <- mydata$income
other <- mydata$other
par(mar=c(5,5,5,6),mgp=c(5,1,0))
plot(total, property, main="State Taxes: Total, Property, Sales (Thousands of dollars)", ylab="")
par(new=T)
plot(total, sales, pch=3, axes=F, ylab="")
axis(side=4)
mtext(side=1,text="total",line=3)
mtext(side=2,text="property",line=3)
mtext(side=4,text="sales",line=3)
legend("center", legend=c("property","sales"), pch=c(1,3))