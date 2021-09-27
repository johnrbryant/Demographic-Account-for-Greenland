
library(demest)

is_15or16_df <- data.frame(age = c(0:99, "100+"),
                           is_15or16 = rep(c(FALSE, TRUE, FALSE), times = c(15, 2, 84)))

prior_age <- DLM(level = Level(scale = HalfT(df = Inf, scale = 0.1)),
                 trend = Trend(scale = HalfT(df = Inf, scale = 0.1)),
                 error = Error(scale = HalfT(df = Inf, scale = 0.1)),
                 damp = NULL)

prior_age_1516 <- DLM(level = Level(scale = HalfT(df = Inf, scale = 0.1)),
                      trend = Trend(scale = HalfT(df = Inf, scale = 0.1)),
                      error = Error(scale = HalfT(df = Inf, scale = 0.1)),
                      damp = NULL,
                      covariates = Covariates(mean ~ is_15or16,
                                              data = is_15or16_df))

prior_time <- DLM(level = Level(scale = HalfT(df = Inf, scale = 0.1)),
                  trend = Trend(scale = HalfT(df = Inf, scale = 0.1)),
                  error = Error(scale = HalfT(df = Inf, scale = 0.1)))



mod_popn <- Model(population ~ Poisson(mean ~ age * sex + time,
                                       useExpose = FALSE),
                  age ~ prior_age,
                  age:sex ~ prior_age,
                  time ~ prior_time,
                  jump = 0.1)

mod_births <- Model(births ~ Poisson(mean ~ age + sex + time),
                    age ~ prior_age,
                    time ~ prior_time,
                    jump = 0.1)

mod_deaths <- Model(deaths ~ Poisson(mean ~ age * sex + time),
                    age ~ prior_age,
                    age:sex ~ prior_age,
                    time ~ prior_time,
                    jump = 0.4)

mod_immigration <- Model(immigration ~ Poisson(mean ~ age * sex + time),
                         age ~ prior_age_1516,
                         age:sex ~ prior_age,
                         time ~ prior_time,
                         jump = 0.4)

mod_emigration <- Model(emigration ~ Poisson(mean ~ age * sex + time),
                        age ~ prior_age_1516,
                        age:sex ~ prior_age,
                        time ~ prior_time,
                        jump = 0.4)



system_models <- list(mod_popn,
                      mod_births,
                      mod_deaths,
                      mod_immigration,
                      mod_emigration)



saveRDS(system_models,
        file = "out/system_models.rds")

