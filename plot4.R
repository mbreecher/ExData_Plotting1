#read data into dataframe
power <- read.table("C:/Users/michael.breecher/Desktop/data/household_power_consumption.txt", 
                    sep = ";", 
                    header = TRUE)
#create an additional field for a date converted from text.
power$date_corrected <- as.Date(power$Date, format = "%d/%m/%Y")
#subset power information to include only 2/1/2007 and 2/2/2007
working_power <- subset(power, power$date_corrected >= "2007-02-01" & power$date_corrected <= "2007-02-02")
#convert global active power string to numeric value. 
working_power$gap_corr <- as.numeric(as.character(working_power$Global_active_power))
#convert metering vectors from factors to numeric
working_power$sm1 <- as.numeric(as.character(working_power$Sub_metering_1))
working_power$sm2 <- as.numeric(as.character(working_power$Sub_metering_2))
working_power$sm3 <- as.numeric(as.character(working_power$Sub_metering_3))
#create additional field for datetime
working_power$datetime <- as.POSIXct(paste(working_power$date_corrected, working_power$Time))

par(mfrow = c(2, 2), mar = c(4,4,.5,.5), oma = c(0,0,0,0), cex.axis = .8, cex.lab = .8)
plot(working_power$datetime, working_power$gap_corr, 
     type = "l", #line type
     xlab = "",
     ylab = "Global Active Power",
)
plot(working_power$datetime, working_power$Voltage, 
     type = "l", #line type
     xlab = "datetime",
     ylab = "Voltage",
     yaxt = 'n'
)
#custom voltage axis
axis(2, at = 1:7*195+700, lab = c("234","","238","","242","","246"))
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
par(xpd = TRUE)
legend("topright", lwd = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1     ", "Sub_metering_2    ", "Sub_metering_3    "), 
       cex = .7, bty = 'n', ncol = 1)

plot(working_power$datetime, working_power$Global_reactive_power, 
     type = "l", #line type
     xlab = "datetime",
     ylab = "Global_reactive_power",
     yaxt = 'n',
)
axis(2, at = 0:5*45, lab = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))