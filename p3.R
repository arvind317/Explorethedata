library("data.table")

setwd("C:/Users/arvin/Desktop/coursera/Explorethedata")

#Read the data from soecified dotu setu
partyDeta <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


partyDeta[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a type of filter graphs etc and that filtered and graphed by time of day
partyDeta[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtered dateu of specified time period
partyDeta <- partyDeta[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("p3.png", width=480, height=480)


plot(partyDeta[, dateTime], partyDeta[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(partyDeta[, dateTime], partyDeta[, Sub_metering_2],col="red")
lines(partyDeta[, dateTime], partyDeta[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()