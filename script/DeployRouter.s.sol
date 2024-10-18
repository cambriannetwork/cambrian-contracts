// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {CambrianRouter} from "../src/CambrianRouter.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DeployRouterScript is Script {
    CambrianRouter public router;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        router = new CambrianRouter();

        vm.stopBroadcast();

        string memory routerAddress = "";

        string memory out = vm.serializeAddress(
            routerAddress,
            "routerAddress",
            address(router)
        );

        // get chain id
        string memory chainId = Strings.toString(block.chainid);

        // include chain id in output file name
        string memory outputFile = string.concat(
            "./script/output/",
            chainId,
            ".json"
        );

        vm.writeJson(out, outputFile);
    }
}
