# CA_LEGAL_AID_CENSUS_DATA
# SOURCE: ACS, 2017 5YR ESTIMATES

##################################################################
# Libraries

library(tidycensus)
library(tidyverse)
library(readr)

##################################################################
# 1: COUNTY POPULATION BELOW 125% FEDERAL POVERTY LEVEL

# Data download

df <- get_acs(geography = "county",
              table = "C17002", 
              cache_table = TRUE,
              year = 2017,
              output = "wide",
              state = "California",
              survey = "acs5")

# Data format

df <- df %>%
  select(GEOID, NAME, C17002_001E, C17002_002E, C17002_003E, C17002_004E) %>%
  mutate(COUNTY = str_remove(NAME," County, California")) %>%
  mutate(POPULATION = C17002_001E) %>%
  mutate(POPULATION_BELOW_FPL_125 = C17002_002E + C17002_003E + C17002_004E) %>%
  mutate(PERCENT_BELOW_FPL_125 = POPULATION_BELOW_FPL_125/POPULATION) %>%
  select(GEOID, COUNTY, POPULATION, POPULATION_BELOW_FPL_125, PERCENT_BELOW_FPL_125) %>%
  arrange(GEOID)
  
# Export csv

write_csv(df, path = "ACS_17_5YR_POP_BELOW_FPL_125_CA_COUNTY.csv")

##################################################################


