# This code connects to Moon Cyanobacteria folder in GDrive
# reads folders and files within folders
# creates a list of filename and folder location
# written: M. Mauritz 7 Mar 2023


moon_all <- list.files("D:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria")


traycheck <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[6],sep="/"))


####################
#Folders with no trays
#Folders I want to run this on: 1, 2, 4, 5, 13, 14
moon14 <-  list.files(paste("D:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[14],sep="/"), pattern="IMG")

# turn the list into a dataframe that can be saved

moon14 <- data.frame(folder=moon_all[14],
                    date=strsplit(moon_all[14],"_")[[1]][1],
                    filename=moon14)

# Save back to GDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")

#save command folders with no trays
write.csv(moon14,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[14],"_")[[1]][1]),".csv",sep=""))


######################

#For folders with trays

#Folders I want to run this on: 3, 6, 7, 8, 9, 10, 11, 12, 15

#list photos in tray folders
moon15.1 <-  list.files(paste("D:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[15],"Tray 1",sep="/"), pattern="IMG")

moon15.2 <-  list.files(paste("D:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[15],"Tray 2",sep="/"), pattern="IMG")

moon15.3 <-  list.files(paste("D:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[15],"Tray 3",sep="/"), pattern="IMG")

#create data frames with photo and date info


moon15.1 <- data.frame(folder=moon_all[15],
                      date=strsplit(moon_all[15],"_")[[1]][1],
                      tray="tray1",
                      filename=moon15.1)


moon15.2 <- data.frame(folder=moon_all[15],
                      date=strsplit(moon_all[15],"_")[[1]][1],
                      tray="tray2",
                      filename=moon15.2)

moon15.3 <- data.frame(folder=moon_all[15],
                    date=strsplit(moon_all[15],"_")[[1]][1],
                    tray="tray3",
                    filename=moon15.3)

# Save back to GDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria/Moon_Cyanbacteria")


#save command folders with trays
write.csv(moon15.1,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[15],"_")[[1]][1]),"_tray1",".csv",sep=""))


write.csv(moon15.2,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[15],"_")[[1]][1]),"_tray2",".csv",sep=""))

write.csv(moon15.3,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[15],"_")[[1]][1]),"_tray3",".csv",sep=""))



