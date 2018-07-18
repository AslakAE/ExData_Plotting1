# Have checked that 1/2/2007 starts at row number 66 637 and that 1/3/2007 starts at 69 517

# Assumes data is in your directory

# Keep headers
header <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", nrows = 1, stringsAsFactors = FALSE)

# Read relevant rows
hpc <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", skip = 66637, nrows = (69517-66637), na.string = "?")

# Use headers
colnames(hpc) <- unlist(header)

# Convert date and Time
hpc$Time <- strptime(hpc$Time, format = "%H:%M:%S")
hpc$Time <- format(hpc$Time, "%H:%M:%S")
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")

#as.POSIXct(paste(hpc$Date, hpc$Time), format = "%d/%m/%Y %H:%M:%S")
hpc["Timestamp"] <- as.POSIXct(paste(hpc$Date, hpc$Time), format = "%Y-%m-%d %H:%M:%S")

# Open png graphic device
png(filename = "./plot2.png")

# Make sure that weekdays are shown in English
Sys.setlocale("LC_TIME", "C")

# Create plot
with(hpc, plot(Timestamp, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()