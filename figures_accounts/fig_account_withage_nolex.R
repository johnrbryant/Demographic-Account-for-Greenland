

library(ggplot2)

data_popn_box <- data.frame(x =    c(0, 2, 2, 0, 1, 0, 0),
                            xend = c(2, 2, 0, 0, 1, 2, 2),
                            y =    c(0, 0, 3, 3, 0, 1, 2),
                            yend = c(0, 3, 3, 0, 3, 1, 2))
data_popn_label <- data.frame(x = c(1, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5),
                              y = c(3.3, 0.5, 0.5, 1.5, 1.5, 2.5, 2.5, -0.4, -0.4),
                              label = c("Population", 7, 8, 4, 9, 5, 6, "italic(t)", "italic(t)+1"))
data_births_box <- data.frame(x =    c(2.5, 3.5, 3.5, 2.5, 2.5, 2.5),
                              xend = c(3.5, 3.5, 2.5, 2.5, 3.5, 3.5),
                              y =    c(0, 0, 3, 3, 1, 2),
                              yend = c(0, 3,   3,     0, 1,   2))
data_births_label <- data.frame(x =  c(3,   3, 3, 3, 3),
                                y =  c(3.35, 0.5, 1.5, 2.5, -0.4),
                                label = c("Births", 0, 7, 0, 'group("[",list(italic(t),italic(t+1)),")")'))
data_deaths_box <- data.frame(x =    c(4, 5, 5, 4, 4, 4),
                              xend = c(5, 5, 4, 4, 5, 5),
                              y =    c(0, 0, 3, 3, 1, 2),
                              yend = c(0, 3, 3, 0, 1, 2))
data_deaths_label <- data.frame(x = c(4.5, 4.5, 4.5, 4.5, 4.5),
                                y = c(3.35, 0.5, 1.5, 2.5, -0.4),
                                label = c("Deaths",3, 1, 7, 'group("[",list(italic(t),italic(t+1)),")")'))
data_immig_box <- data.frame(x =    c(5.5, 6.5, 6.5, 5.5, 5.5, 5.5),
                              xend = c(6.5, 6.5, 5.5, 5.5, 6.5, 6.5),
                              y =    c(0, 0, 3, 3, 1, 2),
                              yend = c(0, 3, 3, 0, 1, 2))
data_immig_label <- data.frame(x = c(6, 6, 6, 6, 6),
                                y = c(3.3, 0.5, 1.5, 2.5, -0.4),
                                label = c("Immigr.",7, 7, 5, 'group("[",list(italic(t),italic(t+1)),")")'))
data_emig_box <- data.frame(x =    c(7, 8, 8, 7, 7, 7),
                             xend = c(8, 8, 7, 7, 8, 8),
                             y =    c(0, 0, 3, 3, 1, 2),
                             yend = c(0, 3, 3, 0, 1, 2))
data_emig_label <- data.frame(x = c(7.5, 7.5, 7.5, 7.5, 7.5),
                               y = c(3.3, 0.5, 1.5, 2.5, -0.4),
                               label = c("Emigr.",1, 5, 3, 'group("[",list(italic(t),italic(t+1)),")")'))
data_age_label <- data.frame(x = rep(-0.3, 3),
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
    ## immig
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_immig_box) +
    geom_text(aes(label = label),
              data = data_immig_label,
              parse = TRUE) +
    ## emig
    geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
                 data = data_emig_box) +
    geom_text(aes(label = label),
              data = data_emig_label,
              parse = TRUE) +
    ## age labels
    geom_text(aes(label = label),
              data = data_age_label) +
    ## other
    xlab("") +
    ylab("")

graphics.off()
pdf(file = "figures_accounts/fig_account_withage_nolex.pdf",
    width = 4,
    height = 2)
plot(p)
dev.off()
