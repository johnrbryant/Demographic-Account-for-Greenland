
library(dplyr)
library(assertr)
library(tidyr)
library(dembase)


pxweb_births <- readRDS("out/pxweb_births.rds")

nonbirths <- readRDS("out/nonbirths.rds")

## Population

head <- nonbirths %>%
    filter(event == "Population (start of year)") %>%
    filter(time == min(time)) %>%
    mutate(time = time - 1L) ## convert to end of year

tail <- nonbirths %>%
    filter(event == "Population (end of year)")

reg_popn <- bind_rows(head, tail) %>%
    verify(triangle == "Lower" | count == 0) %>% ## count is 0 if triangle is Upper
    filter(triangle == "Lower") %>%
    filter(time >= cohort) %>%
    mutate(age = time - cohort) %>%
    verify(!is.na(age) & age >= 0) %>%
    mutate(age = ifelse(age >= 100, "100+", age),
           age = factor(age, levels = c(0:99, "100+"))) %>%
    dtabs(count ~ age + sex + time) %>%
    Counts(dimscales = c(time = "Points"))



## Births

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
    mutate(age = factor(age, levels = seq(from = min(age), to = max(age)))) %>%
    verify(!((triangle == "Undefined") & (count > 0))) %>%
    filter(triangle != "Undefined") %>%
    dtabs(count ~ age + triangle + sex + time) %>%
    Counts(dimscales = c(time = "Intervals"))



## Deaths

reg_deaths <- nonbirths %>%
    filter(event == "Death") %>%
    mutate(age = time - cohort - (triangle == "Upper")) %>%
    mutate(is_valid_age = !is.na(age) & (age >= 0)) %>%
    verify(is_valid_age | (count == 0L)) %>%
    filter(is_valid_age) %>%
    mutate(age = ifelse(age >= 100, "100+", age),
           age = factor(age, levels = c(0:99, "100+"))) %>%
    dtabs(count ~ age + triangle + sex + time) %>%
    Counts(dimscales = c(time = "Intervals"))


## Immigration

reg_immigration <- nonbirths %>%
    filter(event == "Immigration") %>%
    mutate(age = time - cohort - (triangle == "Upper")) %>%
    mutate(is_valid_age = !is.na(age) & (age >= 0)) %>%
    verify(is_valid_age | (count == 0L)) %>%
    filter(is_valid_age) %>%
    mutate(age = ifelse(age >= 100, "100+", age),
           age = factor(age, levels = c(0:99, "100+"))) %>%
    dtabs(count ~ age + triangle + sex + time) %>%
    Counts(dimscales = c(time = "Intervals"))


## Emigration

reg_emigration <- nonbirths %>%
    filter(event == "Emigration") %>%
    mutate(age = time - cohort - (triangle == "Upper")) %>%
    mutate(is_valid_age = !is.na(age) & (age >= 0)) %>%
    verify(is_valid_age | (count == 0L)) %>%
    filter(is_valid_age) %>%
    mutate(age = ifelse(age >= 100, "100+", age),
           age = factor(age, levels = c(0:99, "100+"))) %>%
    dtabs(count ~ age + triangle + sex + time) %>%
    Counts(dimscales = c(time = "Intervals"))



## Collect and return

datasets <- list(reg_popn = reg_popn,
                 reg_births = reg_births,
                 reg_deaths = reg_deaths,
                 reg_immigration = reg_immigration,
                 reg_emigration = reg_emigration)

saveRDS(datasets,
        file = "out/datasets.rds")
        
