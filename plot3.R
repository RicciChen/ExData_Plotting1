### Part I : Select data without reading whole file

##  1. Check and create directory to download file and unzip it.
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip")))
{
        fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        raw <- "./data/exdata_household_power_consumption.zip"
        download.file(fileUrl,destfile=raw,method="auto")
        unzip(zipfile=raw , exdir="./data",)
}
file <- "./data/household_power_consumption.txt"

##  2. Prepare index of selected duration (rows)
Class.1 <- c( rep(c("character"),2) , rep(c("NULL"),7) )
Date.Time<- read.table(file,header=TRUE,sep=";",colClasses=Class.1)
Date.Time$full <-strptime(paste(Date.Time$Date,Date.Time$Time),
                          "%d/%m/%Y %H:%M:%S")
from <- as.Date("2007-02-01")
to   <- as.Date("2007-02-02")       
index<-which(as.Date(Date.Time$full)>=from & 
                     as.Date(Date.Time$full)<= to)

## check if index is continous
# index[1] ; length(index)
# index[length(index)]-index[1]+1

## 3. Get the subset according to index
Class.2 <- c( rep(c("character"),2) , rep(c("numeric"),7) )
header <- read.table("household_power_consumption.txt",sep=";",nrows=1)
header <- as.vector(unlist(header))
data <- read.table("household_power_consumption.txt",sep=";",
                   skip=index[1],nrows= length(index),
                   colClasses=Class.2,na.strings="?",
                   col.names=header,)
data$Date.Time <- Date.Time$full[index]


### Part II : Plotting

## ========== Plotting Plot 3  =============

# 1. call graphic device
png(filename="./data/plot3.png",width = 480, height = 480)

# 2.call plotting fuinction
# prepare blank chart by using y = max(y1,y2,y3)
plot(x=data$Date.Time,y=data$Sub_metering_1,pch=NA,
     xlab="" , ylab= "Energy Sub metering")

# put on lines
lines(x=data$Date.Time,y=data$Sub_metering_1,col="black")
lines(x=data$Date.Time,y=data$Sub_metering_2,col="red")
lines(x=data$Date.Time,y=data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), # line color
       lty=c(1,1,1), # line symbol 
       lwd=c(2,2,2)) # line width

# 3.close graphics device
dev.off()               

