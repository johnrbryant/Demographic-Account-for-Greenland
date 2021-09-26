
## Read data directly from Statistics Greenland website using 'pxweb'

library(pxweb)
library(dplyr)

url <- "http://betabank20.stat.gl/api/v1/en/Greenland/BE/BE80//BEXFERTR.PX"

## database not contain entries for 47 and 49,
## and asking for these ages causes an error
mothers_age <- setdiff(13:50, c(47, 49)) 

query <- list(area = "ALL",
              "mother's year of birth" = as.character(1950:2006), 
              "mother's age" = as.character(mothers_age),
              gender = c("K", "M"),
              time = as.character(2011:2020))

pxweb_births <- pxweb_get(url = url,
                          query = query) %>%
    as.data.frame(column.name.type = "text",
                  variable.value.type = "text")

saveRDS(pxweb_births,
        file = "out/pxweb_births.rds")

