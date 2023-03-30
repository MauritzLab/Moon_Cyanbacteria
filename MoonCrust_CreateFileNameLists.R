# This code connects to Moon Cyanobacteria folder in GDrive
# reads folders and files within folders
# creates a list of filename and folder location
# written: M. Mauritz 7 Mar 2023


moon_all <- list.files("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria")


traycheck <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[6],sep="/"))


####################
#Folders with no trays
#Folders I want to run this on: 1, 2, 4, 5
moon1 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                           moon_all[1],sep="/"), pattern="IMG")

# turn the list into a dataframe that can be saved

moon1 <- data.frame(folder=moon_all[1],
                    date=strsplit(moon_all[1],"_")[[1]][1],
                    filename=moon1)

# Save back to GDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria")

#save command folders with no trays
write.csv(moon2,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[2],"_")[[1]][1]),".csv",sep=""))


######################

#For folders with trays

#Folders I want to run this on: 3, 6

#list photos in tray folders
moon3.1 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[3],"10 24 22 Tray 1",sep="/"), pattern="IMG")

moon3.2 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[3],"10 24 22 Tary 2",sep="/"), pattern="IMG")

moon3.3 <-  list.files(paste("G:/.shortcut-targets-by-id/1UPSTmVsOZCuZ8FOMhJhIO-1E6uzij3to/Moon_Cyanobacteria",
                             moon_all[3],"1- 24 22 Tary 3",sep="/"), pattern="IMG")

#create data frames with photo and date info
moon3.1 <- data.frame(folder=moon_all[3],
                      date=strsplit(moon_all[3],"_")[[1]][1],
                      tray="tray1",
                      filename=moon3.1)


moon3.2 <- data.frame(folder=moon_all[3],
                      date=strsplit(moon_all[3],"_")[[1]][1],
                      tray="tray2",
                      filename=moon3.2)

moon3.3 <- data.frame(folder=moon_all[3],
                    date=strsplit(moon_all[3],"_")[[1]][1],
                    tray="tray3",
                    filename=moon3.3)

# Save back to GDrive
setwd("C:/Users/sgresendez/University of Texas at El Paso/SEL Team Desert + Mauritz Lab - Suellen/Moon Cyanobacteria")


#save command folders with trays
write.csv(moon3.1,row.names=FALSE,
          file=paste("FileInfo_",(strsplit(moon_all[3],"_")[[1]][1]),"_tray1",".csv",sep=""))




