
library(demest)
library(ggplot2)
library(dplyr)
library(tidyr)
library(purrr)

prob <- c(0.025, 0.5, 0.975)


## Population

data_popn_model <- fetch("out/model.est", where = c("account", "population")) %>%
    collapseIterations(prob = prob) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    pivot_wider(names_from = quantile, values_from = count) %>%
    rename(lower = "2.5%", median = "50%", upper = "97.5%")

data_popn_raw <- fetch("out/model.est", where = c("datasets", "reg_popn")) %>%
    midpoints(dimension = "age") %>%
    as.data.frame() %>%
    rename(raw = count)

data_popn <- inner_join(data_popn_model, data_popn_raw,
                        by = c("age", "sex", "time"))


make_popn <- function(time_inner) {
    data_inner <- filter(data_popn, time == time_inner)
    ggplot(data_inner, aes(x = age, group = sex)) +
        facet_wrap(vars(sex),
                   ncol = 2) +
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
        ggtitle(sprintf("Population %d", time_inner))
}    


## Components

components <- c("births", "deaths", "immigration", "emigration")

data_comp_model <- map(components,
                  function(component) fetch("out/model.est", c("account", component))) %>%
    set_names(nm = components) %>%
    map(collapseDimension, dimension = "triangle") %>%
    map(collapseIterations, prob = prob) %>%
    map(midpoints, dimension = "age") %>%
    map(as.data.frame) %>%
    bind_rows(.id = "component") %>%
    pivot_wider(names_from = quantile, values_from = count) %>%
    rename(lower = "2.5%", median = "50%", upper = "97.5%")

data_comp_raw <- map(components, function(component) paste0("reg_", component)) %>%
    map(function(dataset) fetch("out/model.est", c("datasets", dataset))) %>%
    set_names(nm = components) %>%
    map(collapseDimension, dimension = "triangle") %>%
    map(midpoints, dimension = "age") %>%
    map(as.data.frame) %>%
    bind_rows(.id = "component") %>%
    rename(raw = count)

data_comp <- inner_join(data_comp_model, data_comp_raw,
                        by = c("component", "age", "sex", "time"))


make_comp <- function(comp, time_inner) {
    data_inner <- filter(data_comp,
                         component == comp,
                         time == time_inner)
    ggplot(data_inner, aes(x = age, group = sex)) +
        facet_wrap(vars(sex),
                   ncol = 2) +
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
        ggtitle(sprintf("%s %d", comp, time_inner))
}    


## Plot

graphics.off()
pdf(file = "out/fig_account.pdf",
    onefile = TRUE,
    width = 12,
    height = 12)
for (time_inner in unique(data_popn$time)) {
    p <- make_popn(time_inner = time_inner)
    plot(p)
}
for (comp in c("immigration", "emigration")) {
    for (time_inner in unique(data_comp$time)) {
        p <- make_comp(comp = comp,
                       time_inner = time_inner)
        plot(p)
    }
}
dev.off()

