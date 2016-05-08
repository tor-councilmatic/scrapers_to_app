pupa-initdb: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-initdb: ## Runs `pupa update ca_on_toronto`
	cd scrapers && pupa initdb --reset ca

pupa-update: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update: ## Runs `pupa update ca_on_toronto`
	cd scrapers && pupa update ca_on_toronto $(filter-out $@,$(MAKECMDGOALS))

pupa-update-fast: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update-fast: ## Runs `pupa update ca_on_toronto` without rate-limits (only use when cached)
	cd scrapers && pupa update --fastmode ca_on_toronto $(filter-out $@,$(MAKECMDGOALS))

pupa-update-events-full: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update-events-full: ## Runs `pupa update ca_on_toronto`
	cd scrapers && pupa update ca_on_toronto events-full

%:
	@true

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
