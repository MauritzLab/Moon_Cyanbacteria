# Code for Moon Cyano Experiment Phenocam Indices
# Images were processed in phenocam in batches with target ROIs for image shifts
# Phenoanalyzer output is organised by sample ID
# within each sample ID multiple ROIs account for image shifts
# need to select target ROI for each image using notes

# libraries
library(dplyr)
library(tidyr)
library(ggplot2)

# Import Data located in Teams Channel SEL Team Desert + Mauritz Lab
# Map folder to One Drive and then open files from there
# list all csv files in folder (contain data)
mp.files <- list.files("/Users/memauritz/Library/CloudStorage/OneDrive-UniversityofTexasatElPaso/MoonCyanos/PhenoanalyzerOutput", pattern=".csv", full.names=TRUE)
mp.files.nameonly <- list.files("/Users/memauritz/Library/CloudStorage/OneDrive-UniversityofTexasatElPaso/MoonCyanos/PhenoanalyzerOutput", pattern=".csv")

mp <- do.call("rbind", lapply(mp.files[1], header = TRUE, read.table, sep=",", skip = 0,fill=TRUE,
                              na.strings=c(-9999,"#NAME?")))
