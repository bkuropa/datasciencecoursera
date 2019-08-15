library(lattice)
library(reshape2)
library(gridExtra)
setwd("C:/Users/Bryan/Desktop/DATA SCIENCE CERT/Coursera4_ExploratoryDataAnalysis/Ass1")
direct <- getwd()
file.path <- paste(direct,"/household_power_consumption.txt",sep="")

elect <- read.table(file.path,header=TRUE,sep=";",stringsAsFactors = FALSE)
elect$Date <- as.Date(elect$Date,format="%d/%m/%Y")
elect2 <- elect[which(elect$Date >= "2007-02-01" & elect$Date <= "2007-02-02"),]
elect2$Global_active_power <- as.numeric(elect2$Global_active_power)
elect2$Global_reactive_power <- as.numeric(elect2$Global_reactive_power)
elect2$Voltage <- as.numeric(elect2$Voltage)
elect2$combo <- as.POSIXct(paste(elect2$Date, elect2$Time))
elect2$combo2 <- weekdays(elect2$combo,abbreviate = TRUE)

hist(elect2$Global_active_power,col = 2,main = "Global Active Power",
     xlab = "Global active power (kilowatts)",cex.axis=0.8)

