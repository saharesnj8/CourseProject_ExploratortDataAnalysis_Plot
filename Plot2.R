
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




-------------------- Plot 2 -----------------------------  
  
  # Line plot of Global Active Power over 2 days
  
  
  png(
    "plot2.png",
    width=480,
    height=480
  )


plot(datetime, data$Global_active_power,
     type="l",
     xaxt="n",
     xlab="",
     ylab="Global Active Power (kilowatts)"
) 
axis(1, at = pretty(datetime), labels = format(pretty(datetime), "%a")) 

dev.off()

