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

#Convert Date and Time to Date/Time classes
newtime <-strptime(paste(data2$Date, data2$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

#Bind time to current variable
data2 <- cbind(newtime, data2)

#Plot2
plot(data2$newtime, data2$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
