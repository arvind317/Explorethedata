library("data.table")

setwd("C:/Users/arvin/Desktop/coursera/Explorethedata")

#Read the data from file then subsets data 
partyDeT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
partyDeT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable is of being filtered and plotted by time of day
partyDeT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02 yes
partyDeT <- partyDeT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("p2.png", width=480, height=480)


plot(x = partyDeT[, dateTime]
     , y = partyDeT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()