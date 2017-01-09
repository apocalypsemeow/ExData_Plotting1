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

##############
### Plot 2 ###
##############
# Combine power$Date and power$Time variables then convert to date
times <- paste(power$Date, power$Time,sep=" ");                                
times <- strptime(times,format="%e/%m/%Y %H:%M:%S");

# Plot times against Global_Active_Power, then save to plot2.png
plot(times, power$Global_active_power, type="l", xlab="",
     ylab = "Global Active Power")

dev.copy(png, file="plot2.png")
dev.off()