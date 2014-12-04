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
png("plot1.png")
with(hpc,hist(Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()

# clean up
##############################
file.remove("household_power_consumption.txt")
file.remove("exdata-data-household_power_consumption.zip")
