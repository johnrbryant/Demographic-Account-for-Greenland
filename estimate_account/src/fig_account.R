
library(demest)
library(ggplot2)
library(dplyr)
library(tidyr)
library(purrr)

prob <- c(0.025, 0.5, 0.975)

sex_choose <- "Female"
time_choose <- "2020"
series_choose <- "immigration"
series_name <- "Immigration"

## Population

data_popn_model <- fetch("out/model.est", where = c("account", "population")) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose, drop = FALSE) %>%
    collapseIterations(prob = prob) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    select(-time) %>%
    pivot_wider(names_from = quantile, values_from = count) %>%
    rename(lower = "2.5%", median = "50%", upper = "97.5%") %>%
    mutate(series = "Population")

data_popn_raw <- fetch("out/model.est", where = c("datasets", "reg_popn")) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose, drop = FALSE) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    select(-time) %>%
    rename(raw = count) %>%
    mutate(series = "Population")

data_series_model <- fetch("out/model.est", c("account", series_choose)) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose) %>%
    collapseDimension(dimension = "triangle") %>%
    collapseIterations(prob = prob) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    pivot_wider(names_from = quantile, values_from = count) %>%
    rename(lower = "2.5%", median = "50%", upper = "97.5%") %>%
    mutate(series = series_name)

data_series_raw <- fetch("out/model.est", c("datasets", paste("reg", series_choose, sep = "_"))) %>%
    subarray(sex == sex_choose) %>%
    subarray(time == time_choose) %>%
    collapseDimension(dimension = "triangle") %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    rename(raw = count) %>%
    mutate(series = series_name)

data_model <- bind_rows(data_popn_model, data_series_model)

data_raw <- bind_rows(data_popn_raw, data_series_raw)

data <- inner_join(data_model, data_raw, by = c("age", "series")) %>%
    mutate(series = factor(series, levels = c("Population", series_name)))



p <- ggplot(data, aes(x = age)) +
    facet_wrap(vars(series), ncol = 2, scales = "free_y") +
    geom_errorbar(aes(ymin = lower, ymax = upper),
                  col = "darkorange") +
    geom_point(aes(y = median),
               col = "darkorange") +
    geom_line(aes(y = median),
              col = "darkorange",
              size = 0.1) +
    geom_point(aes(y = raw),
               col = "darkblue",
               shape = 4) +
    ylab("") +
    xlab("Age")

## Plot

graphics.off()
pdf(file = "out/fig_account.pdf",
    width = 8,
    height = 7)
plot(p)
dev.off()

