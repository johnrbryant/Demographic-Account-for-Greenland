

## Code to create CSV files with Greenland data
## and put the in the 'data' folder

.PHONY: all
all: ../data/reg_popn.csv \
  ../data/reg_births.csv \
  ../data/reg_deaths.csv \
  ../data/reg_immigration.csv \
  ../data/reg_emigration.csv


## Pull data from Statistics Greenland website --------------------------------

out/pxweb_nonbirths.rds: src/pxweb_nonbirths.R
	Rscript $<


out/pxweb_births.rds: src/pxweb_births.R
	Rscript $<


## Tidy non-births data

out/nonbirths.rds: src/nonbirths.R \
  out/pxweb_nonbirths.rds
	Rscript $<


## Create CSVs ----------------------------------------------------------------


../data/reg_popn.csv: src/reg_popn.R \
  out/nonbirths.rds
	Rscript $<

../data/reg_births.csv: src/reg_births.R \
  out/pxweb_births.rds
	Rscript $<

../data/reg_deaths.csv: src/reg_deaths.R \
  out/nonbirths.rds
	Rscript $<

../data/reg_immigration.csv: src/reg_immigration.R \
  out/nonbirths.rds
	Rscript $<

../data/reg_emigration.csv: src/reg_emigration.R \
  out/nonbirths.rds
	Rscript $<


## Clean up -------------------------------------------------------------------

.PHONY: clean
clean:
	rm -rf out
	mkdir out

