
library(demest)

mod_popn <- Model(reg_popn ~ PoissonBinomial(prob = 0.98),
                  series = "population")

mod_births <- Model(reg_births ~ PoissonBinomial(prob = 0.98),
                    series = "births")

mod_deaths <- Model(reg_deaths ~ PoissonBinomial(prob = 0.98),
                    series = "deaths")

mod_immigration <- Model(reg_immigration ~ PoissonBinomial(prob = 0.95),
                         series = "immigration")

mod_emigration <- Model(reg_emigration ~ PoissonBinomial(prob = 0.95),
                        series = "emigration")


data_models <- list(mod_popn,
                    mod_births,
                    mod_deaths,
                    mod_immigration,
                    mod_emigration)

saveRDS(data_models,
        file = "out/data_models.rds")

