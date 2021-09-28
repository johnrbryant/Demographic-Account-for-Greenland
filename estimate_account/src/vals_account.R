
library(demest)
library(dplyr)
library(tidyr)

sex_choose <- "Female"
time_choose <- "2015"
series_choose <- "emigration"
series_name <- "Emigration"

## Population

vals_popn_model <- fetch("out/model.est", where = c("account", "population")) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose, drop = FALSE) %>%
    collapseIterations(FUN = mean) %>%
    toInteger(force = TRUE) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    select(-time) %>%
    mutate(series = "Population",
           variant = "Adjusted")

vals_popn_raw <- fetch("out/model.est", where = c("datasets", "reg_popn")) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose, drop = FALSE) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    select(-time) %>%
    mutate(series = "Population",
           variant = "Original")

vals_series_model <- fetch("out/model.est", c("account", series_choose)) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose) %>%
    collapseDimension(dimension = "triangle") %>%
    collapseIterations(FUN = mean) %>%
    toInteger(force = TRUE) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    mutate(series = series_name,
           variant = "Adjusted")

vals_series_raw <- fetch("out/model.est", c("datasets", paste("reg", series_choose, sep = "_"))) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose) %>%
    collapseDimension(dimension = "triangle") %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    mutate(series = series_name,
           variant = "Original")

vals_account <- bind_rows(vals_popn_model,
                          vals_popn_raw,
                          vals_series_model,
                          vals_series_raw) %>%
    mutate(series = factor(series, levels = c("Population", series_name)),
           variant = factor(variant, levels = c("Original", "Adjusted")))



saveRDS(vals_account,
        file = "out/vals_account.rds")

