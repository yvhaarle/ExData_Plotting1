library("dplyr")


# read in the data 
all_data <- read.table("household_power_consumption.txt",header= TRUE,sep=";",na.strings="?",colClasses = c("character","character","double","double","double","double","double","double","double"))

# convert string date to actual date
all_data <- mutate(all_data,DatePos = as.Date(Date,"%d/%m/%Y"))

# select only relevant dates
data2plot <- filter(all_data, DatePos >= "2007-02-01", DatePos <= "2007-02-02" )

# remove the all_data out of memory
remove(all_data)

# convert the time and date string to POSIXct time
data2plot <- mutate(data2plot,DateTime = as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))

# now we are ready to plot and save to a png file
png("plot3.png",width = 480, height = 480)

plot(data2plot$DateTime,data2plot$Sub_metering_1,ylab="Energy sub metering",lty=1,type="l",xlab="")
points(data2plot$DateTime,data2plot$Sub_metering_2,col="red",type="l")
points(data2plot$DateTime,data2plot$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))


dev.off()
