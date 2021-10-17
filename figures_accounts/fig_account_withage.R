

library(ggplot2)

data_popn_box <- data.frame(x =    c(0, 2, 2, 0, 1, 0, 0),
                            xend = c(2, 2, 0, 0, 1, 2, 2),
                            y =    c(0, 0, 3, 3, 0, 1, 2),
                            yend = c(0, 3, 3, 0, 3, 1, 2))
data_popn_label <- data.frame(x = c(1, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5),
                              y = c(3.2, 0.5, 0.5, 1.5, 1.5, 2.5, 2.5, -0.15, -0.15),
                              label = c("Population", 7, 6, 4, 5, 5, 6, "italic(t)", "italic(t)+1"))
data_births_box <- data.frame(x =    c(2.5, 3.5, 3.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5),
                              xend = c(3.5, 3.5, 2.5, 2.5, 3.5, 3.5, 3.5, 3.5, 3.5),
                              y =    c(0, 0, 3, 3, 1, 2, 0, 1, 2),
                              yend = c(0, 3,   3,     0, 1,   2, 1, 2, 3))
data_births_label <- data.frame(x =  c(3,   2.7, 3.3, 2.7, 3.3, 2.7, 3.3, 3),
                                y =  c(3.2, 0.7, 0.3, 1.7, 1.3, 2.7, 2.3, -0.15),
                                label = c("Births", 0, 0, 3, 5, 0, 0, 'group("[",list(italic(t),italic(t+1)),")")'))
data_deaths_box <- data.frame(x =    c(4, 5, 5, 4, 4, 4, 4, 4, 4),
                              xend = c(5, 5, 4, 4, 5, 5, 5, 5, 5),
                              y =    c(0, 0, 3, 3, 1, 2, 0, 1, 2),
                              yend = c(0, 3, 3, 0, 1, 2, 1, 2, 3))
data_deaths_label <- data.frame(x = c(4.5, 4.2, 4.7, 4.2, 4.7, 4.2, 4.7, 4.5),
                                y = c(3.2, 0.7, 0.3, 1.7, 1.3, 2.7, 2.3, -0.15),
                                label = c("Deaths", 1, 2, 0, 1, 2, 1, 'group("[",list(italic(t),italic(t+1)),")")'))
data_age_label <- data.frame(x = rep(-0.15, 3),
                             y = c(0.5, 1.5, 2.5),
                             label = c("0", "1", "2+"))
                                       
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
    ## age labels
    geom_text(aes(label = label),
              data = data_age_label) +
    ## other
    xlab("Time") +
    ylab("Age")

graphics.off()
pdf(file = "fig_account_withage.pdf",
    width = 5,
    height = 3.3)
plot(p)
dev.off()
