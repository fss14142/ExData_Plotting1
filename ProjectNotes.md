Project Notes
========================================================

This is the `ProjectNotes.md` file for the "Course Project 1" in the "Exploratory Data Analysis" course (May 2014 ) of 
the Coursera Data Science Specialization. This file contains some additional information about the files I am submitting for this project. See the `README.md` file in the repository for a description of the project.

The repository contains four R scripts, called `plot1.R`, ..., `plot4.R`. As requested by the project description, each one of these scripts constructs a corresponding plot file `plot1.png`, ..., `plot4.pmg`. 

### Assumptions ###

- For the execution of these scripts, It is expected that the `household_power_consumption.zip`, containing the project data, has been downloaded and unzipped in the Working Directory, resulting in the text file:
`household_power_consumption.txt` sitting in that directory. However if only the zip file exists, the script will unzip it. If neither txt or zip file is found, an error is thrown (and execution stops, if you are sourcing the script).
- No additional libraries need to be installed. 

### General outline of the scripts ###

The comments in each of the scripts provide a more detailed description of the steps used to construct each of the plots. Their common outline is as follows:

1. We check for the existence of the data files (see below for details).
2. We read the data files using `read.table`, to keep things simple. To increase speed, and memory performance, we avoid loading unnnecessary data: 
 * using the `colClasses` argument of `read.table` to read only the required columns.
 * using the `skip` argument, to read only the required rows.  
With this strategy, the header of the data file is read separately, in an auxiliary data frame with just the first few lines of the file. The names of the variables are recovered from this auxiliary data frame.       
3. The format for the date and time data in the first two columns of the data frame must be converted to the R representation of date and time data (using `strptime`). This step is not required for plot1
4. The actual plotting step, using the `png` graphics device.     
     
### The zip file name problem ###

This problem may appear when the zip file is used as starting point of the analysis, instead of the `household_power_consumption.txt` text file. For people completing this project this is not an issue if:   

* your script  directly downloads the zip file or
* your script assumes that the txt file has been extracted to the working directory.  

If, however, your script assumes that the zip file has been manually downloaded by the user, and placed in the working directory, then you may need to pay attention to the downloaded file name. For example, Firefox (v 29.0.1) and Chrome (v 34.0.1847.131) give slightly different names to the downloaded files. Concretely:  

* exdata-data-household\_power\_consumption.zip (Chrome)  
* exdata\_data\_household\_power\_consumption.zip (Firefox)     

and besides, the name thta the Coursera staff intended was probably 

*  household\_power\_consumption.zip

Thus the scripts I am submitting include code to check for the presence of any of these zip files, in the event that `household_power_consumption.txt` is not found in the working directory. If neither the txt or zip files can be found, the script throws an error (and, if the script is being sourced, execution stops.)  

### Sourcing the scripts ###

The four scripts can be executed by running this in the R console (provided the scripts are located in the Working Directory): 


    source("plot1.R")
    source("plot2.R")
    source("plot3.R")
    source("plot4.R")

    
    





