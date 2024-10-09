export RPC_URL=http://localhost:8545
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Default target
.PHONY: all
all: clean build test

# Target to run tests
.PHONY: test
test:
	@forge test

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
	@forge script ./script/Router.s.sol \
	    --rpc-url $(RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast

# Target to deploy the test client
.PHONY: deploy-test-client
deploy-test-client: build
	@if [ -z "$(ROUTER_ADDRESS)" ]; then \
        echo "ROUTER_ADDRESS is not set"; \
        exit 1; \
    fi;
	@forge script src/examples/script/Client.s.sol \
	    --rpc-url $(RPC_URL) \
		--private-key $(PRIVATE_KEY) \
		--broadcast \
		--sig "run(address)" \
		$(ROUTER_ADDRESS)
