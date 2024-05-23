#imports file notes that contain sample ID description and filepath for jpegs
#output lists for phenoanalyzer

#load libraries
library(dplyr)
library(readxl)
library(purrr)
library(tidyr)
library(magittr)
library(xlsx)


path<-("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")
#https://stackoverflow.com/questions/33771402/how-to-read-in-multiple-xlsx-files-to-r
#lists all files that start with FileInfo_
url_xlsx <- list.files(path, pattern = "FileInfo_", recursive = TRUE)

#define a function to create a list of dataframes from the FileInfo list
read_xlsx_files <- function(x){
  df <- read_xlsx(x) 
  return(df)
  }

#applying function to url_xlsx, reading 2-33 to avoid "Day 0" file
df <- lapply(url_xlsx[2:33], read_xlsx_files) 




###################################################

# #set working directory and import file
# setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")
# filenotes1<-read_xlsx("FileInfo_20221018.xlsx")
# filenotes2<-read_xlsx("FileInfo_20221024_tray1.xlsx")
# filenotes3<-read_xlsx("FileInfo_20221024_tray2.xlsx")
# filenotes4<-read_xlsx("FileInfo_20221024_tray3.xlsx")
# filenotes5<-read_xlsx("FileInfo_20221031.xlsx")
# filenotes6<-read_xlsx("FileInfo_20221103.xlsx")
# filenotes7<-read_xlsx("FileInfo_20221107_tray1.xlsx")
# filenotes8<-read_xlsx("FileInfo_20221107_tray2.xlsx")
# filenotes9<-read_xlsx("FileInfo_20221107_tray3.xlsx")
# filenotes10<-read_xlsx("FileInfo_20221114_tray1.xlsx")
# filenotes11<-read_xlsx("FileInfo_20221114_tray2.xlsx")
# filenotes12<-read_xlsx("FileInfo_20221114_tray3.xlsx")
# filenotes13<-read_xlsx("FileInfo_20221121_tray1.xlsx")
# filenotes14<-read_xlsx("FileInfo_20221121_tray2.xlsx")
# filenotes15<-read_xlsx("FileInfo_20221121_tray3.xlsx")
# filenotes16<-read_xlsx("FileInfo_20221128_tray1.xlsx")
# filenotes17<-read_xlsx("FileInfo_20221128_tray2.xlsx")
# filenotes18<-read_xlsx("FileInfo_20221128_tray3.xlsx")
# filenotes19<-read_xlsx("FileInfo_20221205_tray1.xlsx")
# filenotes20<-read_xlsx("FileInfo_20221205_tray2.xlsx")
# filenotes21<-read_xlsx("FileInfo_20221205_tray3.xlsx")
# filenotes22<-read_xlsx("FileInfo_20221212_tray1.xlsx")
# filenotes23<-read_xlsx("FileInfo_20221212_tray2.xlsx")
# filenotes24<-read_xlsx("FileInfo_20221212_tray3.xlsx")
# filenotes25<-read_xlsx("FileInfo_20221219_tray1.xlsx")
# filenotes26<-read_xlsx("FileInfo_20221219_tray2.xlsx")
# filenotes27<-read_xlsx("FileInfo_20221219_tray3.xlsx")
# filenotes28<-read_xlsx("FileInfo_20221226.xlsx")
# filenotes29<-read_xlsx("FileInfo_20230102.xlsx")
# filenotes30<-read_xlsx("FileInfo_20230109_tray1.xlsx")
# filenotes31<-read_xlsx("FileInfo_20230109_tray2.xlsx")
# filenotes32<-read_xlsx("FileInfo_20230109_tray3.xlsx")
# filenotes33<-read_xlsx("FileInfo_20221018.xlsx")
# L<-list(filenotes1,filenotes19)
#######################################################




#combine file notes into one file
##select only columns of interest https://stackoverflow.com/questions/73847224/a-function-to-select-specific-columns-in-a-list-of-dataframes-rstudio


########error in "date" column: "!Can't subset columns that don't exist. Column 'date' doesn't exist." 

df1<-map(df, ~ select(., c("date", "sampleID", "onedriveimagepath", "lid_nolid", "original_retake")))
#bind lists into single dataframe: https://stackoverflow.com/questions/2851327/combine-a-list-of-data-frames-into-one-data-frame-by-row
filenotes<-bind_rows(df1)


#check column names
colnames(filenotes1)
colnames(filenotes2)
colnames(filenotes3)
colnames(filenotes4)
colnames(filenotes)

###################################add lid_nolid (1 or 2), retake (1 or 2) to all files
#filter out photos with lids 
#select retake "1" 
#select sample IDs beginning with "L"
#select sample IDs containing "W"
#exclude sample IDs containing "F", only after inoculation date


#########fix colname "original_retake" or change? and resave list filtered for original photos only

filenotes.filter<-filenotes %>% 
  filter(lid_nolid==2)%>%
  filter(original_retake==1)%>%
  filter(grepl('^L', sampleID))%>%
  filter(grepl('W', sampleID))%>%
  filter(!(date>20221204& grepl('F', sampleID)))

#select only image path column for phenoanalyzer
filenotes.pheno<-filenotes.filter%>%
  select(onedriveimagepath)


# Save back to OneDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria/PhenoanalyzerLists")

#save command 
write.table(filenotes.pheno,row.names=FALSE, col.names = FALSE,
            file="PhenoanalyzerLists_20221018_20230109.txt",sep=',')
