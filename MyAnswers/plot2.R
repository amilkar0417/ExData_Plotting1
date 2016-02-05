
rawData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

##Creating new data set with right data
FullDate <- as.POSIXct(paste(rawData[,"Date"], rawData[,"Time"]), format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
Global_active_power <- rawData[,"Global_active_power"]
data1 <- data.frame(FullDate, Global_active_power)

##Selecting only two days
firstDate <- as.POSIXct("2007-02-01", format = "%Y-%m-%d",  tz = "GMT")
secondDate <- as.POSIXct("2007-02-03", format = "%Y-%m-%d", tz = "GMT")
data1 <- subset(data1, FullDate >= firstDate & FullDate < secondDate )

##Changing other datatypes
data1[,"Global_active_power"] <- as.numeric(data1[,"Global_active_power"])

##Deleting incomplete cases
finalData <- data1[complete.cases(data1),]

##Creating PNG file
png("plot2.png", width=480 , height=480, units = "px")

##Creating plot
with(finalData, plot(FullDate, Global_active_power, type="l", col="black",  ylab = "Global Active Power (kilowatts)", xlab = "", xaxt='n'))

##Changing the X Labes as my computer is set in Spanish
minFullDate <- min(finalData$FullDate)
axis(1, at=c(minFullDate, minFullDate+86400, minFullDate+2*86400), labels=c("Thu", "Fri", "Sat"))   

##Closing png file
dev.off()