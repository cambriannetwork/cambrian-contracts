# Cambrian Contracts

## How to run the project

To test the project, you can run the following command:

```bash
make test
```

You can change the chain where the following commands are executed
by setting the `RPC_URL` environment variable in the `.env` file.
Anvil is used by default.

To start anvil run the following command on a separate shell:

```bash
make anvil-start
```

Note that you also need to set the `KEYSTORE_PATH` environment variable in the `.env` file.

If you are using anvil and the default keystore path,
the keystore password is an empty string.

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

## Misc

### How to generate keystore

To generate a keystore you can run the following commands:

1. Create a new wallet
```bash
cast wallet new
```

2. Imprt the keystore
```bash
cast wallet import --interactive <keystore_name>
```

You will be prompted to enter the private key and keystore password.

The keystore will be saved in `~/.foundry/keystores`
