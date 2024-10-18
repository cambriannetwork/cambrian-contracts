// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {CambrianRouter} from "../src/CambrianRouter.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract UpgraderRouterScript is Script {
    CambrianRouter public router;

    function setUp() public {}

    function run() public {
        string memory chainId = Strings.toString(block.chainid);
        string memory outputFile = string.concat(
            "./script/output/",
            chainId,
            ".json"
        );

        // vm.readJson(outputFile);

        vm.startBroadcast();

        router = new CambrianRouter();

        vm.stopBroadcast();

        string memory routerAddress = "";

        string memory out = vm.serializeAddress(
            routerAddress,
            "routerAddress",
            address(router)
        );

        vm.writeJson(out, outputFile);
    }
}
