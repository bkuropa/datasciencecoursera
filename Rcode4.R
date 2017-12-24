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

blackone = function(myvar,myname,dataset) {
      
      xat <- as.POSIXct(c("2007-02-01 00:00:00 EST","2007-02-02 00:00:00 EST","2007-02-03 00:00:00 EST"))
      labxat <- weekdays(xat,abbreviate = TRUE)
      xyplot(myvar~combo, data=dataset,
             type = "l", col=1, 
             scales=list(x=list(at=xat,labels=labxat),tck=c(1,0)),
             xlab = "", ylab = myname,
             cex.axis=0.8)
}
colone = function(myelect2) {
      test <- melt(myelect2,id=c("Date","Time","combo","combo2"))
      test2 <- test[which(test$variable == "Sub_metering_1" | test$variable == "Sub_metering_2"|test$variable == "Sub_metering_3"),]
      xyplot(value~combo,groups = variable,data=test2,type="l",col=c(4,1,2),
             key=list(corner=c(1,1),lines=list(col=c("black","red","blue"), lty=c(1,1,1), lwd=1),
                      text=list(c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))),
             xlab="",ylab="Energy sub metering",ylim=range(0:40),
             scales=list(x=list(at=xat,labels=labxat),tck=c(1,0)),
             cex.axis=0.8)
}

xat <- as.POSIXct(c("2007-02-01 00:00:00 EST","2007-02-02 00:00:00 EST","2007-02-03 00:00:00 EST"))
labxat <- weekdays(xat,abbreviate = TRUE)
par(mfrow=c(2,2))

plot1 <- blackone(elect2$Global_active_power,"Global Active Power",elect2)
plot2 <-blackone(elect2$Voltage,"Voltage",elect2)
plot3 <- colone(elect2)
plot4 <- blackone(elect2$Global_reactive_power, "Global Reactive Power",elect2)

grid.arrange(plot1,plot2,plot3,plot4,ncol=2)
