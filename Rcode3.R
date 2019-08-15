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

#Set x-axis labels for lattice to read and activiate as weekday only
xat <- as.POSIXct(c("2007-02-01 00:00:00 EST","2007-02-02 00:00:00 EST","2007-02-03 00:00:00 EST"))
labxat <- weekdays(xat,abbreviate = TRUE)
#Read sub metering in as factors:
test <- melt(elect2,id=c("Date","Time","combo","combo2"))
test2 <- test[which(test$variable == "Sub_metering_1" | test$variable == "Sub_metering_2"|test$variable == "Sub_metering_3"),]
#Graph plots with descriptive legend
xyplot(value~combo,groups = variable,data=test2,type="l",col=c(4,1,2),
       key=list(corner=c(1,1),lines=list(col=c("black","red","blue"), lty=c(1,1,1), lwd=2),
                text=list(c("Sub_metering_1","Sub_metering_2","Sub_metering_3")),border=TRUE),
       xlab="",ylab="Energy sub metering",ylim=range(0:40),
       scales=list(x=list(at=xat,labels=labxat),tck=c(1,0)),
       cex.axis=0.8)
