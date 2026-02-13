# Data Wrangling in R
# 5.5 Manipulating Strings in R with stringr
# Part 2

# Load the tidyverse and read in the Medicare payments dataset
library(tidyverse)
names <- c("DRG", "ProviderID", "Name", "Address", "City", "State", "ZIP", "Region", "Discharges", "AverageCharges", "AverageTotalPayments", 
           "AverageMedicarePayments")
types = 'ccccccccinnn'
inpatient <- read_tsv('http://594442.youcanlearnit.net/inpatient.tsv', col_names = names, skip=1, col_types = types)

# Separate at the fourth position
inpatient_separate <- separate(inpatient,DRG,c('DRGcode','DRGdescription'),4)

# And take a look at the data now
glimpse(inpatient_separate)

# Trim the DRGcode field
inpatient_separate <- inpatient_separate %>%
  mutate(DRGcode=str_trim(DRGcode))

glimpse(inpatient_separate)

# The DRGdescription field has a hyphen in front so we need to do something different
inpatient_separate <- inpatient_separate %>%
  mutate(DRGdescription=str_sub(DRGdescription, 3))

glimpse(inpatient_separate)
