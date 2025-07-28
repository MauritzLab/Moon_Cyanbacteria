# Code for Moon Cyano Experiment Phenocam Indices
# Images were processed in phenocam in batches with target ROIs for image shifts
# Phenoanalyzer output is organised by sample ID
# within each sample ID multiple ROIs account for image shifts
# need to select target ROI for each image using notes
# code and processing by: M. Mauritz, S. Resendez
# 2024-05-23

# libraries
library(tidyverse)
library(plyr)
library(lubridate)
# If loading tidyverse, don't need to load these individual libraries:
#library(dplyr)
#library(tidyr)
#library(ggplot2)

# Import Data located in Teams Channel SEL Team Desert + Mauritz Lab
# 1. Map folder to One Drive and then open files from there
# 2. list all csv files in folder (contain data)
mp.files <- list.files("/Users/memauritz/Library/CloudStorage/OneDrive-UniversityofTexasatElPaso/MoonCyanos/PhenoanalyzerOutput", pattern=".csv", full.names=TRUE)
# list file names
mp.filenames <- basename(mp.files) 

#
############### Approach 1 to read all files and combine into single dataframe with file name as column #######
# # create a function that reads all csv files and creates a sample ID column name from the file name
# read_csv_colname <- function(colname){
#   ret <- read.table(colname, header = TRUE, sep=",", skip = 0,fill=TRUE,
#                     na.strings=c(-9999,"#NAME?"))
#  # ret$ind_count <- seq(from=1,to=nrow(ret),by=1) # create a count that runs the length of each measurement
#   obj_name <- tools::file_path_sans_ext(basename(colname))
#   ret$sampleID <- obj_name # filename
#   ret
# }
# # create data file of all Phenoanalyser output with Sample ID
# mp.wide <- plyr::ldply(mp.files, read_csv_colname)
############### ############### ############### ############### ############### ############### ############### 
#

# Approach 2 to read all files and combine into single dataframe with file name as column 
# adapted from: https://clauswilke.com/blog/2016/06/13/reading-and-combining-many-tidy-data-files-in-r/
# # read content of csv
 data <- mp.files %>% 
   lapply(read.csv) 
# #map filename to file and create batchfile column
 data_filename<- map2(mp.filenames,data,~cbind(sampleID=.x,.y))
# #binding files into single dataframe
 mp.wide <- unnest(tibble(data_filename), cols=c(data_filename))          


# re-format data from wide to long and split column into informative pieces
mp.long <- mp.wide %>%
  pivot_longer(!c(img, true_ROI, idx_label, sampleID), names_to = "ID",values_to = "value")

# split IDs into descriptor columns for date, ROI, index, and Sample ID
mp.long1<- mp.long %>%
  # separate image name into date
  separate(img, c("img1",NA), sep = ".jpg", remove = TRUE) %>%
  separate(img1,c("date", NA,NA), sep = "_", extra = "merge", fill = "left") %>%
  mutate(date= ymd(date)) %>%
  # separate phenoanalyser column names (ID) into useful components
  separate(ID,c("colorspace","ROI","index"), sep = "\\.", extra = "merge", fill = "left", remove =FALSE) %>%
  mutate(across(c(colorspace, ROI, index),factor)) %>%
  # split sample ID into rep, strain
  separate(sampleID, c("sampleID",NA), sep = ".csv", remove = TRUE) %>%
  separate(sampleID, c(NA,"sampleID"), sep = "PA_", remove = TRUE) %>%
tidyr::extract(sampleID, into = c("rep","strain"), regex = "(\\d+)([A-Z]+)?", remove=FALSE)

#Remove "ROI" from ROI_#
mp.long1<- mp.long1 %>%
  separate(ROI, c(NA, "ROI"), sep = "_") %>%  
  mutate(across(c(ROI),factor)) 

# create a numeric variable for ROI
mp.long1 <- mp.long1 %>%
  mutate(ROI = as.integer(ROI))

# for some reason we have columns that contain no ROI number, view them:
View(mp.long1%>%
       filter(is.na(ROI)))

# and view listing only the disctinct combinations of sample ID and date to make it easier to check
View(mp.long1%>%
       filter(is.na(ROI))%>%
  distinct(sampleID, date))

# Are there rows that have a value in the NA ROI column?
View(mp.long1%>%
       filter(is.na(ROI)&!is.na(value)))

# and view only sampleID and date for those: problem is L7SHW
View(mp.long1%>%
       filter(is.na(ROI)&!is.na(value))%>%
       distinct(sampleID, date))


# filter to keep only the ROI from Phenoanalyzer that matches the true ROI
mp.filt <- mp.long1 %>%
  filter(ROI == true_ROI)

# see what sampleIDs remain
View(mp.filt %>%
  distinct(sampleID, date))

# graph to show all pct green data by sample ID
# use filter to select index
mp.filt%>%
  filter(index=="pctG")%>%
 ggplot (., aes(x=date, y=value, colour=sampleID))+
  geom_point()+
  geom_line()+
  facet_wrap(sampleID~.)

# graph Percent green with line/point color by rep and facet by strain
mp.filt%>%
  filter(index=="pctG")%>%
  ggplot (., aes(x=date, y=value, colour=factor(sampleID)))+
  geom_point()+
  geom_line()+
  facet_wrap(strain~.)

# graph Percent green and red with line/point color by rep and facet by strain
mp.filt%>%
  filter(index %in% c("pctG","pctR"))%>%
  ggplot (., aes(x=date, y=value, colour=factor(sampleID)))+
  geom_point()+
  geom_line()+
  facet_grid(index~strain)


# select only RGB color space and graph all indices
# allow free scales because all indices are on different scales
mp.filt%>%
  filter(colorspace=="RGB")%>%
  ggplot (., aes(x=date, y=value, colour=sampleID))+
  geom_point()+
  geom_line()+
  facet_wrap(index~., scales="free")


# select only HSV color space and graph all indices
# allow free scales because all indices are on different scales
mp.filt%>%
  filter(colorspace=="HSV")%>%
  ggplot (., aes(x=date, y=value, colour=sampleID))+
  geom_point()+
  geom_line()+
  facet_wrap(index~., scales="free")



