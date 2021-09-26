
## Read data directly from Statistics Greenland website using 'pxweb'

library(pxweb)
library(dplyr)

url <- "https://bank.stat.gl/api/v1/en/Greenland/BE/BE80/BEXCALC.PX"

query <- list("year of birth" = as.character(1875:2021),
              "place of birth" = "T",
              event = c("P", "I", "O", "D", "C", "U"), ## excluding "B" for births
              gender = c("K", "M"),
              "triangles(Lexis)" = c("0", "1"),
              time = as.character(2011:2021))

pxweb_nonbirths <- pxweb_get(url = url,
                             query = query) %>%
    as.data.frame(column.name.type = "text",
                  variable.value.type = "text")

saveRDS(pxweb_nonbirths,
        file = "out/pxweb_nonbirths.rds")
