
library(ggplot2)
library(dplyr)
library(tidyr)

data <- readRDS("out/vals_account.rds") %>%
    pivot_wider(names_from = variant, values_from = count) %>%
    mutate(diff = Adjusted - Original)

max_diff <- data %>%
    pull(diff) %>%
    abs() %>%
    max()

p <- ggplot(data, aes(x = age, y = diff)) +
    facet_wrap(vars(series), ncol = 2) +
    geom_point() +
    ylim(-max_diff, max_diff) +
    ylab("") +
    xlab("Age")

graphics.off()
pdf(file = "out/fig_diff.pdf",
    width = 7,
    height = 3.2)
plot(p)
dev.off()

