.PHONY: help build up down install-woo init setup test test-acceptance shell clean db-dump hpos-enable hpos-disable
.PHONY: local-build local-up local-down local-init local-setup local-shell local-clean
.PHONY: test-build test-up test-down test-init test-setup test-shell test-clean

# ===========================================
# TEST ENVIRONMENT (for running Codeception tests)
# ===========================================

DC_TEST = docker compose -f docker-compose.test.yml
ENV_TEST = --env-file .env.test

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# --- Test Environment Commands ---

test-build: ## Build TEST environment containers
	$(DC_TEST) build

test-up: ## Start TEST environment
	$(DC_TEST) up -d

test-down: ## Stop TEST environment
	$(DC_TEST) down

test-install-woo: ## Download and install WooCommerce for TEST environment
	chmod +x install-woocommerce.sh
	./install-woocommerce.sh

test-init: test-build test-up test-install-woo ## Initialize TEST environment (build, up, install WooCommerce)
	@echo "Waiting for WordPress to start..."
	@sleep 10
	@echo "TEST Environment ready!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run 'make test-setup' to configure WordPress + WooCommerce"
	@echo "  2. Run 'make test' to execute tests"

test-setup: ## Setup WordPress + WooCommerce in TEST environment
	$(DC_TEST) exec -e WORDPRESS_URL=http://wordpress php bash /app/setup-wordpress.sh

test: ## Run all tests in TEST environment
	$(DC_TEST) exec php vendor/bin/codecept run

test-acceptance: ## Run acceptance tests only
	$(DC_TEST) exec php vendor/bin/codecept run acceptance

test-verbose: ## Run tests with verbose output
	$(DC_TEST) exec php vendor/bin/codecept run -vvv

test-shell: ## Open a shell in the TEST PHP container
	$(DC_TEST) exec php bash

test-clean: ## Clean up TEST environment
	$(DC_TEST) down -v
	rm -rf woocommerce

test-db-dump: ## Create a database dump for tests
	$(DC_TEST) exec db mysqldump -u wordpress -pwordpress wordpress > tests/_data/dump.sql

test-hpos-enable: ## Enable WooCommerce HPOS in TEST environment
	$(DC_TEST) exec php wp wc hpos sync --allow-root
	$(DC_TEST) exec php wp wc hpos enable --allow-root

test-hpos-disable: ## Disable WooCommerce HPOS in TEST environment
	$(DC_TEST) exec php wp wc hpos sync --allow-root
	$(DC_TEST) exec php wp wc hpos disable --allow-root

# ===========================================
# LOCAL ENVIRONMENT (for development via localhost)
# ===========================================

DC_LOCAL = docker compose -f docker-compose.local.yml

# --- Local Environment Commands ---

local-build: ## Build LOCAL environment containers
	$(DC_LOCAL) build

local-up: ## Start LOCAL environment
	$(DC_LOCAL) up -d

local-down: ## Stop LOCAL environment
	$(DC_LOCAL) down

local-install-woo: ## Download and install WooCommerce for LOCAL environment
	chmod +x install-woocommerce.sh
	./install-woocommerce.sh

local-init: local-build local-up local-install-woo ## Initialize LOCAL environment (build, up, install WooCommerce)
	@echo "Waiting for WordPress to start..."
	@sleep 10
	@echo "LOCAL Environment ready! Access WordPress at http://localhost:8080"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run 'make local-setup' to configure WordPress + WooCommerce"

local-setup: ## Setup WordPress + WooCommerce in LOCAL environment (accessible via localhost:8080)
	$(DC_LOCAL) exec -e WORDPRESS_URL=http://localhost:8080 php bash /app/setup-wordpress.sh

local-shell: ## Open a shell in the LOCAL PHP container
	$(DC_LOCAL) exec php bash

local-clean: ## Clean up LOCAL environment
	$(DC_LOCAL) down -v
	rm -rf woocommerce

local-db-dump: ## Create a database dump from LOCAL environment
	$(DC_LOCAL) exec db mysqldump -u wordpress -pwordpress wordpress > tests/_data/dump.local.sql

local-hpos-enable: ## Enable WooCommerce HPOS in LOCAL environment
	$(DC_LOCAL) exec php wp wc hpos sync --allow-root
	$(DC_LOCAL) exec php wp wc hpos enable --allow-root

local-hpos-disable: ## Disable WooCommerce HPOS in LOCAL environment
	$(DC_LOCAL) exec php wp wc hpos sync --allow-root
	$(DC_LOCAL) exec php wp wc hpos disable --allow-root