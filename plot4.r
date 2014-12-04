# read in data
############################
path = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = path, destfile = "exdata-data-household_power_consumption.zip")
unzip("exdata-data-household_power_consumption.zip")
hpc = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors=FALSE)

# clean and extract data
##############################
hpc$DateTime=strptime(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S")
# hpc$Date=as.Date(hpc$Date, format = "%d/%m/%Y")
# hpc$Time=strptime(hpc$Time, format = "%H:%M:%S")
hpc = subset(hpc, DateTime$year==107)
hpc = subset(hpc, DateTime$mon==1)
hpc = subset(hpc, DateTime$mday%in%c(1,2))

# plot
#############################
attach(hpc)
png("plot4.png")
par(mfcol = c(2,2))
par(mar = c(5.1,4.1,3.1,2.1))

plot(DateTime,Global_active_power,type = "n",xlab = "", ylab = "Global Active Power")
lines(DateTime,Global_active_power)

plot(DateTime,Sub_metering_1,type = "n",xlab = "", ylab = "Energy sub metering")
lines(DateTime,Sub_metering_1,col="black")
lines(DateTime,Sub_metering_2,col="red")
lines(DateTime,Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,col = c("black","red","blue"), box.lty = 0)
box(lty = 1)

plot(DateTime,Voltage,type = "n",xlab = "datetime", ylab = "Voltage")
lines(DateTime,Voltage)

plot(DateTime,Global_reactive_power,type = "n",xlab = "datetime")
lines(DateTime,Global_reactive_power)

dev.off()
detach()

# clean up
##############################
file.remove("household_power_consumption.txt")
file.remove("exdata-data-household_power_consumption.zip")
