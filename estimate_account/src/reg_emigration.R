
## Create 'reg_emigration' data frame from 'nonbirths'

library(dplyr)
library(assertr)
library(readr)
library(tidyr)

nonbirths <- readRDS("out/nonbirths.rds")

reg_emigration <- nonbirths %>%
    filter(event == "Emigration") %>%
    mutate(age = time - cohort - (triangle == "Upper")) %>%
    mutate(is_valid_age = !is.na(age) & (age >= 0)) %>%
    verify(is_valid_age | (count == 0L)) %>%
    filter(is_valid_age) %>%
    mutate(age = ifelse(age >= 100, "100+", age),
           age = factor(age, levels = c(0:99, "100+"))) %>%
    count(age, triangle, sex, time, wt = count, name = "count") %>%
    complete(age, triangle, sex, time, fill = list(count = 0L)) %>%
    arrange(time, sex, age, triangle)

write_csv(reg_emigration,
          file = "../data/reg_emigration.csv")
