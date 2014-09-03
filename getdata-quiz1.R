#Question 1

#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#and load the data into R. The code book, describing the variable names is here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#How many properties are worth $1,000,000 or more?

setwd("F:/Code/R/datacourse/getting&cleaning")
file <- read.csv("getdata-data-ss06hid.csv")
sub <- subset(file,file$VAL>=24)
nrow(sub)
#answer is 53

#Question 3

#Download the Excel spreadsheet on Natural Gas Aquisition Program here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat
#What is the value of: sum(dat$Zip*dat$Ext,na.rm=T) 
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("getdata-data-DATA.gov_NGAP.xlsx",
                 sheetIndex=1,header=TRUE,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
#answer is 3653720

#Question 4

#Read the XML data on Baltimore restaurants from here: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#How many restaurants have zipcode 21231?
library(XML)
doc <- htmlTreeParse("getdata%2Fdata%2Frestaurants.xml",useInternal=TRUE)
restaurants <- xpathSApply(doc,"//zipcode",xmlValue)
answer <- restaurants[which(restaurants=="21231")]
#answer is 127

#Question 5

#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
#using the fread() command load the data into an R object : DT
#Which of the following is the fastest way to calculate the average value of the variable
#pwgtp15
DT <- read.csv("getdata-data-ss06pid.csv")
t1<-Sys.time()
sapply(split(DT$pwgtp15,DT$SEX),mean)
t2<-Sys.time()
dtime <- t2-t1
#Time difference of 0.005001068 secs
t1<-Sys.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
t2<-Sys.time()
dtime <- t2-t1
#Time difference of 0.3760209 secs
t1<-Sys.time()
mean(DT$pwgtp15,by=DT$SEX)
t2<-Sys.time()
dtime <- t2-t1
#Time difference of 0.003000021 secs but not broken down
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#error:Error in rowMeans(DT) : 'x' must be numeric
DT[,mean(pwgtp15),by=SEX]
#Error in `[.data.frame`(DT, , mean(pwgtp15), by = SEX) : 
#unused argument (by = SEX)
t1<-Sys.time()
tapply(DT$pwgtp15,DT$SEX,mean)
t2<-Sys.time()
dtime <- t2-t1
#Time difference of 0.006000042 secs