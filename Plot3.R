
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



-------------------- Plot 3 -----------------------------    
  
  #Plot Sub_metering_1, 2, 3 together.  
  
  png(
    "plot3.png",
    width=480,
    height=480
  )  


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

dev.off() 




