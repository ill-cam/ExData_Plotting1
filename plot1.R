#Download and unzip the files, read the file contents into a data table
temp <- tempfile();
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp);
power <- unzip(temp, "household_power_consumption.txt");
power <- read.table(power, header = TRUE, sep = ";", na.strings = "?");

#Convert the date information to posit class
power$Date <- strptime(power$Date, "%d/%m/%Y");

#Create a subset of the meter dataset that only includes observations recorded on
#Feb 1, 2007 or Feb 2, 2007
newpower <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02");

#Delete the temporary file storing all of the zip file contents
unlink(temp);

#Create a histogram and save it as a png image
png("plot1.png",  width = 480, height = 480, units = "px");
hist(newpower$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)");
dev.off()