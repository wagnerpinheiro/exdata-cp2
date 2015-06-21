readData <- function(){
  
  file1 <- 'summarySCC_PM25.rds'
  
  # download and unzip file if not exists in current directory
  if(length(dir(".", pattern=file1)) == 0 ){
    # download file to working folder
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', destfile = "data.zip", method = 'curl')
    
    # unzip file in working folder
    unzip("data.zip")
    file.remove("data.zip")
  }
  
  print("Loading Data...")
  # read PM25 data to NEI variable in global environment 
  NEI <<- readRDS("summarySCC_PM25.rds")
  
  # read Source Classification Code Table to SCC variable in global environment
  SCC <<- readRDS("Source_Classification_Code.rds")
  
  print("Data Loaded.")
}