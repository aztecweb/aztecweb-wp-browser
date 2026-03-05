.PHONY: help build up down install-woo init setup test test-acceptance shell clean

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build Docker containers
	docker compose build

up: ## Start Docker containers
	docker compose up -d

down: ## Stop Docker containers
	docker compose down

install-woo: ## Download and install WooCommerce
	chmod +x install-woocommerce.sh
	./install-woocommerce.sh

init: build up install-woo ## Initialize the test environment (build, up, install WooCommerce)
	@echo "Waiting for WordPress to start..."
	@sleep 10
	@echo "Environment ready! Access WordPress at http://localhost:8080"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run 'make setup' to configure WordPress + WooCommerce and create the database dump"
	@echo "  2. Run 'make test' to execute tests"

setup: ## Setup WordPress + WooCommerce and create database dump
	docker compose exec php bash /app/setup-wordpress.sh

test: ## Run all tests
	docker compose exec php vendor/bin/codecept run

test-acceptance: ## Run acceptance tests only
	docker compose exec php vendor/bin/codecept run acceptance

test-verbose: ## Run tests with verbose output
	docker compose exec php vendor/bin/codecept run -vvv

shell: ## Open a shell in the PHP container
	docker compose exec php bash

clean: ## Clean up Docker containers and volumes
	docker compose down -v
	rm -rf woocommerce

db-dump: ## Create a database dump for tests
	docker compose exec db mysqldump -u wordpress -pwordpress wordpress > tests/_data/dump.sql

hpos-enable: ## Enable WooCommerce HPOS (sync data first, then enable)
	docker compose exec php wp wc hpos sync
	docker compose exec php wp wc hpos enable

hpos-disable: ## Disable WooCommerce HPOS (sync data first, then disable)
	docker compose exec php wp wc hpos sync
	docker compose exec php wp wc hpos disable
