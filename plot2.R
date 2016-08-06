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

#Create a line chart and save it as a png image
png("plot2.png",  width = 480, height = 480, units = "px");
plot(newpower$event, newpower$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)");
dev.off()