#Create directory first

if (!file.exists("./data")) {
        dir.create("./data")
}

#Set variables for download

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "./data/project.zip"
hpcfile <- "./data/household_power_consumption.txt"

#Download and Unzip zip file 

if (!file.exists(hpcfile)) {
        download.file(downloadURL, downloadFile, method = "curl")
        unzip(downloadFile, overwrite = T, exdir = "./data")
}

#Load data in to R and remove missing values
data <- read.table(hpcfile, na.strings = "?", header = T, sep=";")

#Subsets the Date column given dates specified
data2 <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

#Remove missing values
na.omit(data2)

#Convert Date and Time to Date/Time classes
newtime <-strptime(paste(data2$Date, data2$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

#Bind time to current variable
data2 <- cbind(newtime, data2)

#Plot 4
#labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(data2$newtime, data2$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(data2$newtime, data2$Voltage, type="l", col="black", xlab="", ylab="Voltage")
plot(data2$newtime, data2$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data2$newtime, data2$Sub_metering_2, type="l", col="red")
lines(data2$newtime, data2$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=c(1,1,1), col=columnlines)
plot(data2$newtime, data2$Global_reactive_power, type="l", col="black", xlab="", ylab="Global_reactive_power")

# Save to png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
