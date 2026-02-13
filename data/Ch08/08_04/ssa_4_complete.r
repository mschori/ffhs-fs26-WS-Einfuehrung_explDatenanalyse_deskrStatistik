# Data Wrangling in R
# Social Security Disability Case Study

# Load the tidyverse
library(tidyverse)
library(lubridate)
library(stringr)

# Read in the coal dataset
ssa <- read_csv("http://594442.youcanlearnit.net/ssadisability.csv")

# Take a look at how this was imported
glimpse(ssa)

# Make the dataset long
ssa_long <- pivot_longer(ssa, !Fiscal_Year, names_to='month', values_to='applications')

# And what do we get?
print(ssa_long, n=20)

# Split the month and application type
ssa_long <- ssa_long %>%
  separate(month, c("month", "application_method"), sep="_")

# What does that look like?
print(ssa_long, n=20)

# What values do we have for months?
unique(ssa_long$month)

# Convert month to standard abbreviations
ssa_long <- ssa_long %>%
  mutate(month=substr(month,1,3))

# What values do we now have for months and years?
unique(ssa_long$month)
unique(ssa_long$Fiscal_Year)

# Convert Fiscal_Year from alphanumeric strings to actual years
ssa_long <- ssa_long %>%
  mutate(Fiscal_Year=str_replace(Fiscal_Year, "FY", "20"))

# What values do we now have for years?
unique(ssa_long$Fiscal_Year)

# Build a date string using the first day of the month
paste('01', ssa_long$month, ssa_long$Fiscal_Year)

ssa_long <- ssa_long %>%
  mutate(date=dmy(paste("01", ssa_long$month, ssa$Fiscal_Year)))

# What do those look like?
unique(ssa_long$date)
