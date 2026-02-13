# Data Wrangling in R
# 3.7 Importing Excel Files into R

# School breakfast program data
# Reading data stored in Excel

# Load the tidyverse
library(tidyverse)

# The readxl package isn't part of the core tidyverse so we need to load it separately
library(readxl)

# Try just reading the file without other arguments
breakfast <- read_excel('breakfast.xlsx')
glimpse(breakfast)

# Try skipping three lines

breakfast <- read_excel('breakfast.xlsx', skip=3)
glimpse(breakfast)

# It looks like we need to skip five lines, which will remove the column names
# So lets create a vector with column names
names <- c("Year", "FreeStudents", "ReducedStudents", "PaidStudents", "TotalStudents", 
           "MealsServed", "PercentFree")

# And then try reading the file again
breakfast <- read_excel('breakfast.xlsx',skip=5, col_names = names)
glimpse(breakfast)

# I'll do a little quick manipulation of this tibble. 
# First, convert the numbers of students and meals to real values
breakfast <- breakfast %>%
  mutate(FreeStudents=FreeStudents*1000000,
         ReducedStudents=ReducedStudents * 1000000,
         PaidStudents = PaidStudents * 1000000,
         TotalStudents = TotalStudents * 1000000,
         MealsServed = MealsServed * 1000000,
         PercentFree = PercentFree/100)

glimpse(breakfast)
