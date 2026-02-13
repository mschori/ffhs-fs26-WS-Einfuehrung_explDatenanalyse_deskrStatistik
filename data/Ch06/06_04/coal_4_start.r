# Data Wrangling in R
# Coal Consumption Case Study

# Load the tidyverse
library(tidyverse)

# Read in the coal dataset
coal <- read_csv("http://594442.youcanlearnit.net/coal.csv")
glimpse(coal)

# Skip the first two lines
coal <- read_csv("http://594442.youcanlearnit.net/coal.csv", skip=2)
glimpse (coal)

# Rename the first column as region
colnames(coal)[1] <- "region"
summary(coal)

# Convert from a wide dataset to a long dataset using pivot_longer
coal_long <- pivot_longer(coal, !region, names_to='year', values_to='coal_consumption')
glimpse(coal_long)

# Convert years to integers
coal_long <- coal_long %>%
  mutate(year=as.integer(year))

summary(coal_long)

# Convert coal consumption to numeric
coal_long <- coal_long %>%
  mutate(coal_consumption=as.numeric(coal_consumption))

summary(coal_long)

