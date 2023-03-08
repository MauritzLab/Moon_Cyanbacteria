# This code connects to Moon Cyanobacteria folder in GDrive
# reads folders and files within folders
# creates a list of filename and folder location
# written: M. Mauritz 7 Mar 2023


moon_all <- list.files("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria")
 
moon1 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[1],sep="/"), pattern="IMG")

moon2 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[2],sep="/"), pattern="IMG")

# turn the list into a dataframe that can be saved
moon1 <- data.frame(folder=moon_all[1],
                    date=strsplit(moon_all[1],"_")[[1]][1],
                    filename=moon1)

# Save back to GDrive
setwd("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria/Phenoanalyser_Files")

write.csv(moon1,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[1],"_")[[1]][1]),".csv",sep=""))
