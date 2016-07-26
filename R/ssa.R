# assumes RESS package has already been installed
# if this has not been installed, run install.packages("RESS")
setwd("~/essentia-scripts/sh")
library(RESS)
mydata <- read.essentia("ssasetup.sh")
summary(mydata)
cadata <- mydata[mydata$state=="CA",]
summary(cadata)
year <- cadata$year
pop <- cadata$pop1864
pct <- cadata$pct
plot(year, pop)
plot(year, pct)
reg1 <- lm(year ~ pop + pct, data=cadata)
summary(reg1)
plot(reg1)
reg1$residuals
plot(year, reg1$residuals)
