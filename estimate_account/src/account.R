
library(dembase)
library(dplyr)

datasets <- readRDS("out/datasets.rds")

account <- Movements(population = datasets$reg_popn,
                     births = datasets$reg_births,
                     entries = list(immigration = datasets$reg_immigration),
                     exits = list(deaths = datasets$reg_deaths,
                                  emigration = datasets$reg_emigration)) %>%
    makeConsistent()

saveRDS(account,
        file = "out/account.rds")

