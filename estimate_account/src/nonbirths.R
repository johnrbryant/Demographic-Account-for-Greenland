
## Tidy non-births data

library(dplyr)

pxweb_nonbirths <- readRDS("out/pxweb_nonbirths.rds")

nonbirths <- pxweb_nonbirths %>%
    tibble() %>%
    select(cohort = "year of birth",
           event,
           sex = gender,
           triangle = "triangles(Lexis)",
           time,
           count = "Population Accounts") %>%
    filter(!is.na(count)) %>%
    filter(cohort <= time) %>%
    mutate(cohort = as.integer(cohort),
           time = as.integer(time),
           count = as.integer(count))

saveRDS(nonbirths,
        file = "out/nonbirths.rds")
