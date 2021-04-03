library("data.table")
setwd("C:/Users/arvin/Desktop/coursera/Explorethedata")
party <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
party[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
party[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
party <- party[(Date >= "2007-02-01") & (Date < "2007-02-03")]
png("p1.png", width=480, height=480)

hist(party[,Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts", ylab="Frequency", col="Red")
dev.off()
