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

# Combine power$Date and power$Time variables then convert to date
times <- paste(power$Date, power$Time,sep=" ");                                
times <- strptime(times,format="%e/%m/%Y %H:%M:%S");


##############
### Plot 4 ###
##############
# 4 Separate plots of each variable in power data over time,
# then save to plot4.png
par(mfcol=c(2,2))
with(power, {
  plot(times, Global_active_power, type="l", xlab="",
       ylab = "Global Active Power") # Plot 1
  plot(times, Sub_metering_1, col="black", type="l", xlab="",
       ylab="Energy sub metering") # Plot 2
  points(times, Sub_metering_2, col="red", type="l")
  points(times, Sub_metering_3, col="blue", type="l")
  legend("topright", lty=1, col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(times, Voltage, type="l", xlab="datetime", ylab="Voltage") # Plot 3
  plot(times, Global_reactive_power, type="l", xlab="datetime") # Plot 4
})

dev.copy(png, file="plot4.png")
dev.off()

