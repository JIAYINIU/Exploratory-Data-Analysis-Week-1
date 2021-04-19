## Downloads data
Data <-
  read.table(
    "/Users/jiayiniu/Downloads/household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?",
    colClasses = c(
      'character',
      'character',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric',
      'numeric'
    ),
    col.names = c(
      "Date",
      "Time",
      "Global_active_power",
      "Global_reactive_power",
      "Voltage",
      "Global_intensity",
      "Sub_metering_1",
      "Sub_metering_2",
      "Sub_metering_3"
    ))

## Tidy the data    
# Reformat date to standard date form
Data$Date <- as.Date(Data$Date, "%d/%m/%Y")
    
# Filter data set from Feb.1 2007 to Feb.2 2007
Data <-subset(Data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
    
# Remove incomplete observations
Data <- Data[complete.cases(Data), ]
    
# Combine Date and Time column
dateTime <- paste(Data$Date, Data$Time)
    
# Rename the vector
dateTime <- setNames(dateTime, "DateTime")
    
# Drop the Date and Time columns
Data <- Data[-c(1,2)]
    
# Add DateTime column
Data <- cbind(dateTime, Data)
    
# Format dateTime Column
Data$dateTime <- as.POSIXct(dateTime)

## PLot 1
# Create the histogram
hist(Data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
