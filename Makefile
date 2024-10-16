RPC_URL:=http://localhost:8545
KEYSTORE_PATH:=./anvil.keystore.json

-include .env

# Default target
.PHONY: all
all: clean build

# Target to build the project
.PHONY: build
build:
	@forge build

# Target to clean the project
.PHONY: clean
clean:
	@forge clean

.PHONY: anvil-start
anvil-start:
	@anvil

# Target to deploy the router
.PHONY: deploy-router
deploy-router: build
	@echo "Using keystore path: $(KEYSTORE_PATH)"

	@forge script ./script/Router.s.sol \
	    --rpc-url $(RPC_URL) \
		--keystore $(KEYSTORE_PATH) \
		--broadcast
