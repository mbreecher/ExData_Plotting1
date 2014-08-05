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
#plot histogram
hist(working_power$gap_corr, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")