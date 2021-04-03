library("data.table")

setwd("C:/Users/arvin/Desktop/coursera/Explorethedata")


partydeta <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


partydeta[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


partydeta[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


partydeta <- partydeta[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("p4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(partydeta[, dateTime], partydeta[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

plot(partydeta[, dateTime],partydeta[, Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(partydeta[, dateTime], partydeta[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(partydeta[, dateTime], partydeta[, Sub_metering_2], col="red")
lines(partydeta[, dateTime], partydeta[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(partydeta[, dateTime], partydeta[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()