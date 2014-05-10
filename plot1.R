## Data Science Specialization
## Coursera & Johns Hopkins University
## Course: Exploratory Data Analysis (May 2014)
## Course Project 1. 
## File: plot1.R
## This is the required file that constructs the graphic file plot1.png.

## Initial cleanup.
rm(list=ls())

## We start checking if this script is in the Working Directory.
## If it is not, a message is issued.
if(!file.exists("plot1.R")){
    message("Are you executing this plot1.R script from your Working Directory?")
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
            message(paste("Data file", zipFile, 
                          "successfully unzipped.", collapse=" "))
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
## For this script we will only use the first three columns.
columnsToOmit <- 4:9
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
#  head(hshldPwrConsumption)
#  tail(hshldPwrConsumption)

###################
## STEP3: Plotting
###################


## We set the active plotting device to ong with the desired size,
## and transparent background (as in the provided example files).
png(file="plot1.png", width = 480, height = 480, bg="transparent")
activeDevice <- dev.cur()
## The actual plot: 
hist(hshldPwrConsumption$Global_active_power, col="red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
## and the graphics device is closed.
dev.off(activeDevice)

#######################
## End of file plot1.R
#######################

