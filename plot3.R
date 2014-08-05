#read data into dataframe
power <- read.table("C:/Users/michael.breecher/Desktop/data/household_power_consumption.txt", 
                    sep = ";", 
                    header = TRUE)
#create an additional field for a date converted from text.
power$date_corrected <- as.Date(power$Date, format = "%d/%m/%Y")
#subset power information to include only 2/1/2007 and 2/2/2007
working_power <- subset(power, power$date_corrected >= "2007-02-01" & power$date_corrected <= "2007-02-02")
#convert metering vectors from factors to numeric
working_power$sm1 <- as.numeric(as.character(working_power$Sub_metering_1))
working_power$sm2 <- as.numeric(as.character(working_power$Sub_metering_2))
working_power$sm3 <- as.numeric(as.character(working_power$Sub_metering_3))
#create additional field for datetime
working_power$datetime <- as.POSIXct(paste(working_power$date_corrected, working_power$Time))

plot(working_power$datetime, working_power$sm1, 
     type = "l", #line type
     xlab = "",
     ylab = "Energy sub metering"
     )
points(working_power$datetime, 
       working_power$sm2, 
       type = "l", col = "red")
points(working_power$datetime, working_power$sm3, type = "l", col = "blue")
#add legend
legend("topright", lwd = 2.5, col = c("black", "blue", "red"), 
       legend = c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"))