
importActData <- function(destFolder) {
      ## IMPORT all relevant files from the given folders:
      xtrain <- read.table(paste(destFolder,"/train/X_train.txt",sep=""),sep = "")
      ytrain <- read.csv(paste(destFolder,"/train/Y_train.txt",sep=""),header=FALSE,stringsAsFactors=FALSE)
      subtrain <- read.csv(paste(destFolder,"/train/subject_train.txt",sep=""),header=FALSE,stringsAsFactors=FALSE)
      subtest <- read.csv(paste(destFolder,"/test/subject_test.txt",sep=""),header=FALSE,stringsAsFactors=FALSE)
      ytest <- read.csv(paste(destFolder,"/test/Y_test.txt",sep=""),header=FALSE,stringsAsFactors=FALSE)
      xtest <- read.table(paste(destFolder,"/test/X_test.txt",sep=""),sep = "")
      desname <- read.csv(paste(destFolder,"/features.txt",sep=""),header=FALSE,sep=" ",stringsAsFactors = FALSE)
      actnames <- read.csv(paste(destFolder,"/activity_labels.txt",sep=""),sep = " ",header=FALSE,stringsAsFactors = FALSE)

      ## MERGE both training and test data into one large data set:
      subtotal <- rbind(subtrain,subtest)
      xtotal <- rbind(xtrain,xtest)
      ytotal <- rbind(ytrain,ytest)

      ## LABEL all columns with DESCRIPTIVE column names:
      desname <- read.csv(paste(destFolder,"/features.txt",sep=""),header=FALSE,sep=" ",stringsAsFactors = FALSE)
      names(xtotal) <- desname[,2]
      names(ytotal) <- "activitylabels"
      names(subtotal) <- "subject"
      # Total dataset:
      totaltbl <- cbind(subtotal,ytotal,xtotal)
      return(totaltbl)
}

## EXTRACT relevant columns to new table (i.e. "mean","std" columns)
extractSTATS <- function(mytable) {
      
      tblout <- mytable[,1:2]
      for(i in 3:ncol(mytable)) {
            
            if(grepl("mean", tolower(colnames(mytable[i]))) == 1 | grepl("std", tolower(colnames(mytable[i]))) == 1 ) {
                  tblout <- cbind(tblout,mytable[,i])
                  colnames(tblout)[ncol(tblout)] <- colnames(mytable)[i]
                  }
      }
      return(tblout)
}

## SET activity names in place of #s 1 - 6
setActNames <- function(mytable,nametbl) {
      
      tblout <- mytable
      tblout$activitylabels <- as.character(tblout$activitylabels)
      for(i in 1:nrow(tblout)) {
            for (j in 1:nrow(nametbl)) {
                  if (tblout[i,2] == nametbl[j,1]) {tblout[i,2] = nametbl[j,2]}
            }
      }
      return(tblout)
}

## CREATE smaller table of mean and standard dev columns
meanTable <- function(mytable,nametbl) {
      
      meantbl <- data.frame()
      
      for (i in 1:length(unique(mytable$subject))){  #for each subject number 1 - 30
            for(j in 1:nrow(nametbl)){  #for each activity listed in activity_labels.txt
                  grpdata <- subset(mytable,subject == i &
                                    activitylabels == nametbl[j,2],
                                    drop=FALSE)
                  
                  meanvect <- colMeans(grpdata[,3:ncol(grpdata)])
                  meanvect <- t(as.data.frame(meanvect))
                  
                  #(Re)attach non-numeric columns after colMeans function executes:
                  frontvect <- as.data.frame(grpdata[1,1:2])
                  
                  newline <- cbind(frontvect,meanvect)
                  meantbl <- rbind(meantbl,newline)
            }
      }
      return(meantbl)
}

## TIDY column names according to "tidy" data lectures
cleanNames <- function(mytable) {
      for(i in 1:ncol(mytable)) {
            clnname <- tolower(colnames(mytable)[i])
            clnname <- gsub("[[:punct:]]", "", clnname)
            colnames(mytable)[i] <- clnname
      }
      return(mytable)
}

##EXECUTE all functions giving location of parent folder
tidyData <- function(location){
      library(dplyr)
      #location <- readline(prompt="Enter folder location or type 'pass' for working directory: ")
      #if(location=='pass'){location = getwd()}
      print("Please wait: Importing data")
      totaldata <- importActData(location)
      
      print("Data import finished. Processing:")
      meanstd <- extractSTATS(totaldata)
      meanstd <- setActNames(meanstd,actnames)
      avgdata <- meanTable(meanstd,actnames)
      avgdata <- cleanNames(avgdata)
      return(avgdata)
}
