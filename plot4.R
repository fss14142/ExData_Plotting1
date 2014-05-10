## Data Science Specialization
## Coursera & Johns Hopkins University
## Course: Exploratory Data Analysis (May 2014)
## Course Project 1. 
## File: plot4.R
## This is the required file that constructs the graphic file plot4.png.

## Initial cleanup.
rm(list=ls())

## We start checking if this script is in the Working Directory.
## If it is not, a message is issued.
if(!file.exists("plot4.R")){
    message("Are you executing this plot4.R script from your Working Directory?")
}

###############################################
## STEP1: Checking the existence of data files
###############################################

# This step is common to all the files in the project.

## It is expected that the 'exdata_data_household_power_consumption.zip', 
## containing the project data, has been downloaded and unzipped in 
## the Working Directory, resulting in the text file:
## 'household_power_consumption.txt' sitting in that directory.
## However if only the zip file exists, the script will unzip it.
## If neither txt or zip file is found, an error is thrown.
## See the ProjectNotes.md file in the repository for further details.

txtFileName <- "household_power_consumption.txt"
txtFilePresent <- file.exists(txtFileName)

# Several different versions of the zip file name must be considered,
# since different browsers can result in different names.
zipFileNames <- character(3)
zipFileNames[1] <- "exdata-data-household_power_consumption.zip"
zipFileNames[2] <- "exdata_data_household_power_consumption.zip"
zipFileNames[3] <- "household_power_consumption.zip"

# We check for the existence of any of these zip files:
(checkZipFiles <- sapply(zipFileNames, FUN=file.exists))
zipFilePresent <- ifelse(sum(checkZipFiles)>0, min(which(checkZipFiles)), 0)


if(!txtFilePresent){
    ## If the txt file does not exist, but the zip file does, we issue a warning
    ## and try to extract the data to the zip file.
    message(paste(txtFileName, " not found. Trying zip file.", collapse="") )
    if(zipFilePresent > 0){
        zipFile <- zipFileNames[zipFilePresent]
        unzip(zipFile)
        ## Check the txt file after unzipping.
        if(file.exists(txtFileName)){
            message(paste("Data file", zipFile, "successfully unzipped.",collapse=" "))
        }
    } else {
        ## if zip file does not exist either, execution stops with an error message.
        workingDir <- getwd()
        message(paste("Your working directory is: ", workingDir, collapse=""))
        message(paste("No zip file or text file: ", txtFileName, 
                      " was found.", collapse=""))
        stop("No suitable data files found. Stopping execution.")
    }
}

###############################################
## STEP2: Read data
###############################################

## The columns read from the file are different in other project files. 

## We use read.table to read the data,
## skipping the first 66637 rows, and then reading 
## the 2*24*60 lines corresponding to dates/times  between
## 1/2/2007 00:00:00  and 2/2/2007 23:59:00.
## Only the required columns are read, using colClasses.
## First we set to NULL the type of the columns to be omitted.

(columns <- c("character", "character", rep("numeric", 7)))
## For this script we will load all the columns (col. 5 is not used).
columnsToOmit <- c()
columns[columnsToOmit] <- rep("NULL",length(columnsToOmit))

## Next we read in the selected lineas and columns.
hshldPwrConsumption <- 
    read.table("household_power_consumption.txt", sep=";", 
               skip=66637, nrows=(2*24*60), na.strings="?", colClasses=columns)

## The header has been omitted, so we read again the first line into an 
## auxiliary data frame to get the variable names.

dataHeader <- 
    read.table(file="household_power_consumption.txt",  
               header=TRUE, na.strings="?", nrows=2, sep=";", check.names=TRUE, 
               colClasses=columns)

## and we use the names in that data frame to fix hshldPwrConsumption
names(hshldPwrConsumption) <- names(dataHeader)

## Uncomment the following two lines to check the data frame. 
# head(hshldPwrConsumption)
# tail(hshldPwrConsumption)

#################################
## STEP3: Managing date and time 
#################################

# To apply strptime, first we paste the first two columns. 
datetime1 <- paste(hshldPwrConsumption$Date, hshldPwrConsumption$Time, sep=" ")
# strptime converts them to the desired data type.
datetime <- strptime(datetime1, format="%d/%m/%Y %H:%M:%S")
## Uncomment the following two lines to check the conversion. 
# head(datetime)
# tail(datetime)


###################
## STEP4: Plotting
###################

## We set the locale to get "Thu, Fri, Sat" (for non-English users).
Sys.setlocale("LC_TIME", "C")

## We set the active plotting device to ong with the desired size,
## and transparent background (as in the provided example files).
png(file="plot4.png", width = 480, height = 480, bg="transparent")
activeDevice <- dev.cur()

## We use par and mfrow to prepare the 2x2 plot arrangement.

par(mfrow=c(2, 2))

## The top left plot is similar to plot2 (the y axis label is different)
plot(datetime, hshldPwrConsumption$Global_active_power, 
     type="l", main="", xlab="", ylab="Global Active Power")

## The top right plot:
plot(datetime,hshldPwrConsumption$Voltage, 
     type="l", main="", ylab="Voltage")


## The bottom left plot is similar to plot3: 
plot(datetime,hshldPwrConsumption$Sub_metering_1,type="l",main="",xlab="",ylab="Energy sub metering")
points(datetime,hshldPwrConsumption$Sub_metering_2,type="l",col="red")
points(datetime,hshldPwrConsumption$Sub_metering_3,type="l",col="blue")
## Next, the legend is created. Note the cex parameter to adjust the font size,
## and the selection of the variable names for the legend. Also, no box for 
## the legend, using bty="n": 
legend("topright",legend=names(hshldPwrConsumption)[7:9], lty=c(1,1,1),bty="n", 
       col=c("black","red","blue"),cex=0.8 )

## The bottom right plot need some label and axis adjustment: 
plot(datetime, hshldPwrConsumption$Global_reactive_power, 
     type="l", main="", ylab="Global_reactive_power", yaxt="n")
axis(side=2, at=seq(0,0.5,length.out=6),cex.axis=0.7)


## and the graphics device is closed.
dev.off(activeDevice)

#######################
## End of file plot4.R
#######################

