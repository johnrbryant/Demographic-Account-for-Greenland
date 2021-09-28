

## Code to create CSV files with Greenland data
## and put the in the 'data' folder

.PHONY: all
all: out/fig_values.pdf \
     out/fig_diff.pdf


## Pull data from Statistics Greenland website --------------------------------

out/pxweb_nonbirths.rds: src/pxweb_nonbirths.R
	Rscript $<


out/pxweb_births.rds: src/pxweb_births.R
	Rscript $<


## Tidy non-births data

out/nonbirths.rds: src/nonbirths.R \
  out/pxweb_nonbirths.rds
	Rscript $<


## Estimate account -----------------------------------------------------------

out/datasets.rds: src/datasets.R \
  out/pxweb_births.rds \
  out/nonbirths.rds
	Rscript $<

out/data_models.rds: src/data_models.R
	Rscript $<

out/system_models.rds: src/system_models.R
	Rscript $<

out/account.rds: src/account.R \
  out/datasets.rds
	Rscript $<

out/model.est: src/model.R \
  out/datasets.rds \
  out/data_models.rds \
  out/system_models.rds \
  out/account.rds
	Rscript $<


## Graph results --------------------------------------------------------------

out/vals_account.rds: src/vals_account.R \
  out/model.est
	Rscript $<

out/fig_values.pdf: src/fig_values.R \
  out/vals_account.rds
	Rscript $<

out/fig_diff.pdf: src/fig_diff.R \
  out/vals_account.rds
	Rscript $<



## Clean up -------------------------------------------------------------------

.PHONY: clean
clean:
	rm -rf out
	mkdir out

