# Data Wrangling in R
# 5.5 Manipulating Strings in R with stringr
#

# Load the tidyverse and the food inspections dataset
library(tidyverse)

names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", "Address", 
           "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude","Longitude","Location")

inspections <- read_csv('http://594442.youcanlearnit.net/inspections.csv', 
                        col_names=names, skip=1)

# Create a new column called Regions that combines City and State
regional_inspections <- unite(inspections,Region,City,State,sep=", ", remove=FALSE)

# And take a look at the unique regions
unique(regional_inspections$Region)

# We need to load stringr separately
library(stringr)

# Let's handle the uppercase/lowercase issues by converting everything to uppercase
regional_inspections <- regional_inspections %>%
  mutate(Region=str_to_upper(Region))


# What were the results of that?
unique(regional_inspections$Region)

# Let's take care of a few misspellings of Chicago
badchicagos <- c('CCHICAGO, IL', 'CHCICAGO, IL', 'CHICAGOCHICAGO, IL', 'CHCHICAGO, IL', 'CHICAGOI, IL')

regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region %in% badchicagos, 'CHICAGO, IL', Region)) 
  
# And see what's left
unique(regional_inspections$Region)

# There are some "CHICAGO, NA" values that we can clearly correct to "CHICAGO, IL"
regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region=='CHICAGO, NA', 'CHICAGO, IL', Region)) 

# But we don't know what to do with "NA, IL", "NA, NA", or "INACTIVE, IL"
# so let's set those to missing values
nachicagos <- c('NA, IL', 'NA, NA', 'INACTIVE, IL')

regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region %in% nachicagos, NA, Region)) 

# How did we do?
unique(regional_inspections$Region)
