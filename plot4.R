#Download and unzip the files, read the file contents into a data table
temp <- tempfile();
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp);
power <- unzip(temp, "household_power_consumption.txt");
power <- read.table(power, header = TRUE, sep = ";", na.strings = "?");

#Create a new vector that combines the date and time information for each
#observation in the power dataset
event <- paste(power$Date, power$Time);

#Convert the values of this vector to posit class
event <- strptime(event, "%d/%m/%Y %H:%M:%S");

#Convert the date information to posit class
power$Date <- strptime(power$Date, "%d/%m/%Y");

#Add the "event" vector to the main "power" dataset
power <- cbind(power, event);

#Create a subset of the meter dataset that only includes observations recorded on
#Feb 1, 2007 or Feb 2, 2007
newpower <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02");

#Delete the temporary file storing all of the zip file contents
unlink(temp);

#Open the png graphics device and start creating an image with one line chart in
#each of four panels
png("plot4.png",  width = 480, height = 480, units = "px");
par(mfcol = c(2,2));

#Create four line charts--one for each panel in the png image file
with(newpower, {
  plot(event, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)");
  plot(event, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering");
  points(event, Sub_metering_1, type = "l");
  points(event, Sub_metering_2, type = "l", col = "red");
  points(event, Sub_metering_3, type = "l", col = "blue");
  legend("topright", pch = 151, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
  plot(event, Voltage, type = "l", xlab = "datetime");
  plot(event, Global_reactive_power, type = "l", xlab = "datetime");
});
dev.off()