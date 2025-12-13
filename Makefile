include .env
MIGRATIONS_PATH = ./cmd/migrate/migrations

.PHONY: migrate-create
migration:
	@migrate create -seq -ext sql -dir $(MIGRATIONS_PATH) $(filter-out $@,$(MAKECMDGOALS))

.PHONY: migrate-up
migrate-up:
	@migrate -path=$(MIGRATIONS_PATH) -database=$(DB_MIGRATOR_ADDR) up

.PHONY: migrate-down
migrate-down:
	@migrate -path=$(MIGATIONS_PATH) -database=$(DB_MIGRATOR_ADDR) down  $(filter-out, $@,$(MAKECMDGOALS))

.PHONY: migrate-version
migrate-version:
	@migrate -path=$(MIGRATIONS_PATH) -database=$(DB_MIGRATOR_ADDR) version
	
.PHONY: migrate-force
migrate-force:
	@read -p "Force version to: " version; \
	migrate -path=$(MIGRATIONS_PATH) -database=$(DB_MIGRATOR_ADDR) force $$version

.PHONY: seed
seed: 
	@go run cmd/migrate/seed/main.go
