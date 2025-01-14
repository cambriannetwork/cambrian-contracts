// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Vm} from "forge-std/Vm.sol";
import {IClient, Log} from "../src//Cambrian.sol";
import {CambrianRouter} from "../src/CambrianRouter.sol";
import {ClientBase} from "../src/ClientBase.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {stdJson} from "forge-std/StdJson.sol";

contract Client is ClientBase, IClient {
    mapping(uint256 => uint8) messages;

    int256 public token0 = 0;
    int256 public token1 = 0;

    struct Swap {
        address sender;
        address recipient;
        int256 amount0;
        int256 amount1;
        uint160 sqrtPriceX96;
        uint128 liquidity;
        int24 tick;
    }

    constructor(address router)
        ClientBase(
            CambrianRouter(router),
            "name=Swap&network=1&address=88e6a0c2ddd26feeb64f039a2c41296fcb3f5640&signature=c42079f94a6350d7e6235f29174924f928cc2ac818eb64fed8004e115fbcca67&topic_count=3&data_length=160"
        )
    {}

    function executeQuery(uint64 startBlock, uint64 endBlock) external returns (uint256) {
        uint256 messageId = execute(startBlock, endBlock);
        messages[messageId] = 0;
        return messageId;
    }

    function handleSuccess(uint256 messageId, bytes memory data, Log[] calldata logs) external override {
        Swap[] memory swaps = abi.decode(data, (Swap[]));
        console.log("Swaps: ", swaps.length);
        console.log("Logs: ", logs.length);
        console.log("Message: ", messageId);
        handleData(swaps, logs);
    }

    function handleData(Swap[] memory data, Log[] calldata logs) public {
        int256 s0 = 0;
        int256 s1 = 0;

        for (uint32 i = 0; i < data.length; i++) {
            s0 += data[i].amount0;
            s1 += data[i].amount1;
        }

        token0 += s0;
        token1 += s1;
    }

    function handleStatus(uint256 messageId, uint8 status, string calldata message) external override {
        messages[messageId] = status;
    }
}

contract DeployTest is Script {
    using stdJson for string;

    function setUp() public {}

    function run() public {
        string memory chainId = Strings.toString(block.chainid);
        string memory outputFile = string.concat("./script/output/", chainId, ".json");
        string memory outputFileJson = vm.readFile(outputFile);
        address router = outputFileJson.readAddress(".routerProxyAddress");

        vm.startBroadcast();

        Client client = new Client(router);

        console.log("Client: ", address(client));

        vm.stopBroadcast();

        string memory outputJson = "";

        string memory output = vm.serializeAddress(outputJson, "client", address(client));

        vm.writeJson(output, string.concat("./script/output/", chainId, ".test.json"));
    }
}

contract CallTest is Script {
    Client client;

    function setUp() public {
        string memory chainId = Strings.toString(block.chainid);
        string memory outputFile = string.concat("./script/output/", chainId, ".test.json");
        address cad = vm.parseJsonAddress(vm.readFile(outputFile), ".client");
        client = Client(cad);
    }

    function run(uint64 startBlock, uint64 endBlock) public {
        vm.startBroadcast();

        console.log("client-token0: ", client.token0());
        console.log("client-token1: ", client.token1());
        client.executeQuery(startBlock, endBlock);

        vm.stopBroadcast();
    }
}
