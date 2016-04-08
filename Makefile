pupa-update: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update: ## Runs `pupa update ca_on_toronto`
	cd scrapers && pupa update --fastmode ca_on_toronto $(filter-out $@,$(MAKECMDGOALS))

%:
	@true

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
