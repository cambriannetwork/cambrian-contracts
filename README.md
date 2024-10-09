# Cambrian Contracts

## How to run the project

To test the project, you can run the following command:

```bash
make test
```

You can change the chain where the following commands are executed
by setting the `RPC_URL` environment variable. By default anvil is used.

To start anvil run the following command on a separate shell:

```bash
make anvil-start
```

Note that you also need to set the `PRIVATE_KEY` environment variable.

To deploy the Cambrian Router, you can run the following command:

```bash
make deploy-router
```

To deploy the Test Client you can run the following command:

```bash
make deploy-test-client ROUTER_ADDRESS=<router_address>
```

Where `<router_address>` is the address of the Cambrian Router
(which is output when running make deploy-router).
