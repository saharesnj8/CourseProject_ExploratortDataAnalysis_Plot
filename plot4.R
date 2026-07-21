
file.info("household_power_consumption.txt")$size / 1024^2

data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)
data

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data

data <- subset(data,
               Date == "2007-02-01" |
                 Date == "2007-02-02"
)
data


data[, 3:9] <- sapply(data[, 3:9], as.numeric)

datetime <- strptime(
  paste(data$Date, data$Time),
  format = "%Y-%m-%d %H:%M:%S"
)

head(datetime)



-------------------- Plot 4 -----------------------------    
  
  #Four plots in a 2×2 grid.  
  
  
  png(
    "plot4.png",
    width=480,
    height=480
  ) 


par(mfrow=c(2,2))  


### Plot 1: Global Active Power

plot(datetime, data$Global_active_power,
     type="l",
     xaxt="n",
     xlab="",
     ylab="Global Active Power (kilowatts)"
) 
axis(1, at = pretty(datetime), labels = format(pretty(datetime), "%a")) 


### Plot 2: Voltage


plot(datetime, data$Voltage,
     type="l",
     xlab="",
     ylab="Voltage (volts)",
     xaxt="n",
     col="black")
axis(1, at = pretty(datetime), labels = format(pretty(datetime), "%a"))


### Plot 3: Sub_metering (1, 2, 3)


plot(datetime, data$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering",
     xaxt="n",
     col="black"
)

lines(datetime, data$Sub_metering_2, col="red")
lines(datetime, data$Sub_metering_3, col="blue")  

axis(1, at = pretty(datetime), labels = format(pretty(datetime), "%a"))  

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1
)


### Plot 4: Global Reactive Power

plot(datetime, data$Global_reactive_power,
     type="l",
     xlab="",
     ylab="Global Reactive Power (kilowatts)",
     xaxt="n",
     col="black")
axis(1, at = pretty(datetime), labels = format(pretty(datetime), "%a"))

dev.off()
