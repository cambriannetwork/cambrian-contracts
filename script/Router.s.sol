// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {CambrianRouter} from "../src/CambrianRouter.sol";

contract RouterScript is Script {
    CambrianRouter public router;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        router = new CambrianRouter();

        vm.stopBroadcast();
    }
}
