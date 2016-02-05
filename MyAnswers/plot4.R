
rawData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

##Creating new data set with right data
FullDate <- as.POSIXct(paste(rawData[,"Date"], rawData[,"Time"]), format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
Sub_metering_1 <- rawData[,"Sub_metering_1"]
Sub_metering_2 <- rawData[,"Sub_metering_2"]
Sub_metering_3 <- rawData[,"Sub_metering_3"]
Global_active_power <- rawData[,"Global_active_power"]
Global_reactive_power <- rawData[,"Global_reactive_power"]
Voltage <- rawData[,"Voltage"]
data1 <- data.frame(FullDate, Sub_metering_1, Sub_metering_2, Sub_metering_3, Global_active_power, Global_reactive_power, Voltage)

##Selecting only two days
firstDate <- as.POSIXct("2007-02-01", format = "%Y-%m-%d",  tz = "GMT")
secondDate <- as.POSIXct("2007-02-03", format = "%Y-%m-%d", tz = "GMT")
data1 <- subset(data1, FullDate >= firstDate & FullDate < secondDate )

##Transforming to the right data types
data1[,"Global_active_power"] <- as.numeric(data1[,"Global_active_power"])
data1[,"Global_reactive_power"] <- as.numeric(data1[,"Global_reactive_power"])
data1[,"Voltage"] <- as.numeric(data1[,"Voltage"])
data1[,"Sub_metering_1"] <- as.numeric(data1[,"Sub_metering_1"])
data1[,"Sub_metering_2"] <- as.numeric(data1[,"Sub_metering_2"])
data1[,"Sub_metering_3"] <- as.numeric(data1[,"Sub_metering_3"])

##Deleting incomplete cases
finalData <- data1[complete.cases(data1),]


png("plot4.png", width=480 , height=480, units = "px")

par(mfrow = c(2,2))

with(finalData, 
        {
        plot(FullDate, Global_active_power, type="l", col="black",  ylab = "Global Active Power", xlab = "", xaxt='n')
        ##Changing the X Labes as my computer is set in Spanish
        minFullDate <- min(finalData$FullDate)
        axis(1, at=c(minFullDate, minFullDate+86400, minFullDate+2*86400), labels=c("Thu", "Fri", "Sat"))   
        
        
        
        plot(FullDate, Voltage, type= "l", col="black", ylab="Voltage", xlab = "datetime", xaxt='n')
        ##Changing the X Labes as my computer is set in Spanish
        minFullDate <- min(finalData$FullDate)
        axis(1, at=c(minFullDate, minFullDate+86400, minFullDate+2*86400), labels=c("Thu", "Fri", "Sat"))   
        
        
        plot(FullDate, Sub_metering_1, type="l", col="black", ylab = "Energy sub metering", xlab = "", xaxt='n')
        lines(finalData[,"FullDate"],finalData[,"Sub_metering_2"],col="red")
        lines(finalData[,"FullDate"],finalData[,"Sub_metering_3"],col="blue")
        legend("topright",  lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
        
        ##Changing the X Labes as my computer is set in Spanish
        minFullDate <- min(finalData$FullDate)
        axis(1, at=c(minFullDate, minFullDate+86400, minFullDate+2*86400), labels=c("Thu", "Fri", "Sat"))   

        plot(FullDate, Global_reactive_power, type="l", col="black",  ylab = "Global_reactive_power", xlab = "Datetime", xaxt='n')
        ##Changing the X Labes as my computer is set in Spanish
        minFullDate <- min(finalData$FullDate)
        axis(1, at=c(minFullDate, minFullDate+86400, minFullDate+2*86400), labels=c("Thu", "Fri", "Sat"))   
        
        
        
        }
)
     

dev.off()