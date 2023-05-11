#imports file notes that contain sample ID description and filepath for jpegs
#output lists for phenoanalyzer

#load libraries
library(dplyr)
library(readxl)

#set working directory and import file
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")
filenotes1<-read.csv("20221018FilePath.csv", header=TRUE, sep=",", dec=".")
filenotes2<-read_xlsx("20221205Tray1Filepath.xlsx")
filenotes3<-read_xlsx("20221205Tray2Filepath.xlsx")
filenotes4<-read_xlsx("20221205Tray3Filepath.xlsx")





#combine file notes into one file
filenotes<-rbind(filenotes1,filenotes2,filenotes3,filenotes4)

#check column names
colnames(filenotes1)
colnames(filenotes2)
colnames(filenotes3)
colnames(filenotes4)
colnames(filenotes)


#filter out photos with lids 
#select retake "1" 
#select sample IDs beginning with "L"
#select sample IDs containing "W"
#exclude sample IDs containing "F", only after inoculation date



filenotes.filter<-filenotes %>% 
  filter(lid_nolid==2)%>%
  filter(original_retake==1)%>%
  filter(grepl('^L', sampleID))%>%
  filter(grepl('W', sampleID))%>%
  filter(!(date>20221204& grepl('F', sampleID)))

#select only image path column for phenoanalyzer
filenotes.pheno<-filenotes.filter%>%
  select(onedriveimagepath, date)


# Save back to OneDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria/PhenoanalyzerLists")

#save command 
write.csv(filenotes.pheno,row.names=FALSE,
          file="PhenoanalyzerLists_20221018_20221205.csv")




##random testing 

#filter out photos with lids and retakes
filenotes=filter(filenotes,!lid_nolid %in% c(1), !original_retake %in% (2))


#list with no lids, originals only
originals_nolids<-read.csv("originals_nolids.csv")

#to filter
originals_nolids%>%
  filter(grepl('L', sampleID) & grepl('W', sampleID), !grepl('F', sampleID))

#to create list with filter applied
filenotes.filter <- filenotes %>% filter(grepl('SYM', sampleID) & grepl('W', sampleID) & !grepl('F', sampleID))

originals_nolids.filter<-originals_nolids%>%
  filter(grepl('L', sampleID) & grepl('W', sampleID), !grepl('F', sampleID))

#to save
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")

write.csv(originals_nolids.filter,row.names=FALSE,
          file=paste("LWNoF",".csv",sep=""))




