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

##############
### Plot 1 ###
##############
# Read data into R using read.csv.sql() then creates a histogram
power <- read.csv.sql("household_power_consumption.txt",
                      sql='select * from file where Date = "1/2/2007" or Date = "2/2/2007"',
                      header=TRUE, sep=";")

hist(power$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")

# Copies the plot to a png file named plot1.png
dev.copy(png, file="plot1.png")
dev.off()

