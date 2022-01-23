

library(ggplot2)


data_popn_box <- data.frame(x = c(0, 2, 2, 0, 1),
                            xend = c(2, 2, 0, 0, 1),
                            y = c(0, 0, 1, 1, 0),
                            yend = c(0, 1, 1, 0, 1))
data_popn_label <- data.frame(x = c(1, 0.5, 1.5, 0.5, 1.5),
                              y = c(1.35, 0.5, 0.5, -0.4, -0.4),
                              label = c("Population", 16, 17, "italic(t)", "italic(t)+1"))
data_births_box <- data.frame(x = c(2.5, 3.5, 3.5, 2.5),
                              xend = c(3.5, 3.5, 2.5, 2.5),
                              y = c(0, 0, 1, 1),
                              yend = c(0, 1, 1, 0))
data_births_label <- data.frame(x = c(3, 3, 3),
                                y = c(1.4, 0.5, -0.4),
                                label = c("Births", 8, 'group("[",list(italic(t),italic(t+1)),")")'))
data_deaths_box <- data.frame(x = c(4, 5, 5, 4),
                              xend = c(5, 5, 4, 4),
                              y = c(0, 0, 1, 1),
                              yend = c(0, 1, 1, 0))
data_deaths_label <- data.frame(x = c(4.5, 4.5, 4.5),
                                y = c(1.4, 0.5, -0.4),
                                label = c("Deaths", 7, 'group("[",list(italic(t),italic(t+1)),")")'))
p <- ggplot(data_popn_box, aes(x = x, y = y)) +
    theme_bw() +
    theme(panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank()) +
    coord_cartesian(expand = FALSE,
                    clip = "off") +
    ## population
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_popn_box) +
    geom_text(aes(label = label),
              data = data_popn_label,
              parse = TRUE) +
    ## births
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_births_box) +
    geom_text(aes(label = label),
              data = data_births_label,
              parse = TRUE) +
    ## deaths
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_deaths_box) +
    geom_text(aes(label = label),
              data = data_deaths_label,
              parse = TRUE) +
    ## other
    xlab("") +
    ylab("")

graphics.off()
pdf(file = "figures_accounts/fig_account_noage.pdf",
    width = 2.5,
    height = 1)
plot(p)
dev.off()
