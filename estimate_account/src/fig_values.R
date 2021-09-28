
library(ggplot2)
library(dplyr)

vals_account <- readRDS("out/vals_account.rds")

p <- ggplot(vals_account, aes(x = age, y = count, color = variant)) +
    facet_wrap(vars(series), ncol = 2, scales = "free_y") +
    geom_line() +
    scale_color_manual(values = c("black", "grey")) +
    ylab("") +
    xlab("Age") +
    theme(legend.title = element_blank(),
          legend.position = "top")

graphics.off()
pdf(file = "out/fig_values.pdf",
    width = 7,
    height = 4)
plot(p)
dev.off()

