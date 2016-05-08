pupa-dbinit: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-dbinit: ## Reset/initiate the database
	cd scrapers && pupa dbinit --reset ca

pupa-update: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update: ## Runs `pupa update ca_on_toronto`
	cd scrapers && pupa update ca_on_toronto $(filter-out $@,$(MAKECMDGOALS))

pupa-update-fast: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update-fast: ## Runs `pupa update ca_on_toronto` without rate-limits (only use when cached)
	cd scrapers && pupa update --fastmode ca_on_toronto $(filter-out $@,$(MAKECMDGOALS))

pupa-update-events: export OCD_DIVISION_CSV=../country-ca-toronto.csv
pupa-update-events: ## Runs `pupa update ca_on_toronto events-full`
	cd scrapers && pupa update ca_on_toronto events-full

mark-cancelled-events: pupa-update-events ## Mark non-updated events (+1hr) as cancelled
	psql $(DATEBASE_URL) -c "UPDATE opencivicdata_event SET status='cancelled' WHERE updated_at < current_date - interval '1' hour"

%:
	@true

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
