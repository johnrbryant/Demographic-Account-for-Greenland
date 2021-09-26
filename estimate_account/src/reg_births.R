
## Create 'reg_births' data frame from 'pxweb_births'

library(dplyr)
library(assertr)
library(readr)
library(tidyr)

pxweb_births <- readRDS("out/pxweb_births.rds")

reg_births <- pxweb_births %>%
    select(cohort = "mother's year of birth",
           age = "mother's age",
           sex = gender,
           time,
           count = "Live births by Greenland's administrative division") %>%
    mutate(cohort = as.integer(cohort),
           age = as.integer(age),
           time = as.integer(time),
           count = as.integer(count)) %>%
    mutate(triangle = case_when(age == time - cohort ~ "Lower",
                                age == time - cohort - 1 ~ "Upper",
                                TRUE ~ "Undefined")) %>%
    verify(!((triangle == "Undefined") & (count > 0))) %>%
    filter(triangle != "Undefined") %>%
    mutate(age = factor(age, levels = seq(from = min(age), to = max(age)))) %>%
    select(age, triangle, sex, time, count) %>%
    complete(age, triangle, sex, time, fill = list(count = 0L)) %>%
    arrange(time, sex, age, triangle) %>%
    tibble()

write_csv(reg_births,
          file = "../data/reg_births.csv")
