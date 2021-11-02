

library(ggplot2)

data_popn_box <- data.frame(x =    c(0, 2, 2, 0, 1, 0),
                            xend = c(2, 2, 0, 0, 1, 2),
                            y =    c(0, 0, 2, 2, 0, 1),
                            yend = c(0, 2, 2, 0, 2, 1))
data_popn_label <- data.frame(x = c(1, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5),
                              y = c(2.2, 0.5, 0.5, 1.5, 1.5, -0.4, -0.4),
                              label = c("Population", 10, 14, 15, 11, "italic(t)", "italic(t)+1"))
data_mig_box <- data.frame(x =     c(3, 5, 5, 3, 4, 3),
                            xend = c(5, 5, 3, 3, 4, 5),
                            y =    c(0, 0, 2, 2, 0, 1),
                            yend = c(0, 2, 2, 0, 2, 1))
data_mig_label <- data.frame(x =   c(4, 3.5,  4.5, 3.5, 4.5,  4, 2.8, 2.8),
                             y =  c(2.5, 0.5, 1.5, 2.2, 2.2, -0.4, 0.5, 1.5),
                             label = c("Moves", 1, 5, "A", "B",
                                       'group("[",list(italic(t),italic(t+1)),")")',
                                       "B", "A"))

data_region_label <- data.frame(x = rep(-0.2, 2),
                                y = c(0.5, 1.5),
                                label = c("B", "A"))
                                       
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
    ## mig
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_mig_box) +
    geom_text(aes(label = label),
              data = data_mig_label,
              parse = TRUE) +
    ## region labels
    geom_text(aes(label = label),
              data = data_region_label) +
    ## other
    xlab("") +
    ylab("")

graphics.off()
pdf(file = "figures_accounts/fig_account_region.pdf",
    width = 3.2,
    height = 1.8)
plot(p)
dev.off()
