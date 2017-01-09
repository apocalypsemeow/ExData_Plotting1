# This script reads data from household_power_consumption.txt
# from the UC Irvine Machine Learning Repository, then creates
# plots of Global Active Power (in kilowatts) and Energy
# sub metering

# Installs Package sqldf if not already installed then loads
# base plotting system
if (!require("sqldf")){ 
  install.packages("sqldf") 
}
library(sqldf)
library(graphics)
library(grDevices)

# Read data into R using read.csv.sql() then creates a histogram
power <- read.csv.sql("household_power_consumption.txt",
                      sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"',
                      header=TRUE, sep=";")

times <- paste(power$Date, power$Time,sep=" ");                                
times <- strptime(times,format="%e/%m/%Y %H:%M:%S");


##############
### Plot 3 ###
##############
# Energy sub metering plot against time, which is saved to plot3.png
plot(times, power$Sub_metering_1, col="black", type="l", xlab="",
     ylab="Energy sub metering")
points(times, power$Sub_metering_2, col="red", type="l")
points(times, power$Sub_metering_3, col="blue", type="l")
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png")
dev.off()