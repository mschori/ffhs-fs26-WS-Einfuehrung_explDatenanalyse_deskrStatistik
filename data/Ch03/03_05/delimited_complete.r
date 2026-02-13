# Data Wrangling in R
# 3.5 Importing Delimited Files into R

# Work stoppages in the United States from the Bureau of Labor Statistics
# Reading data from a carat-delimited file

# Load the tidyverse
library(tidyverse)

# Use the read_delim function to look at the file 
stoppages <- read_delim(file='http://594442.youcanlearnit.net/workstoppages.txt', delim='^')

glimpse(stoppages)
