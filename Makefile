help: ## Help File
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

start: ## Boot the application
	npm run serve

build-n-run: ## Build and Server 'dist' using HTTP server
	npm run build && http-server dist

build: ## Build the app
	npm run build