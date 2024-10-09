// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Client} from "../Client.sol";
import {CambrianRouter} from "../../lib/CambrianRouter.sol";

contract RouterScript is Script {
    Client public client;

    function setUp() public {}

    function run(address router) public {
        vm.startBroadcast();

        client = new Client(CambrianRouter(router));

        vm.stopBroadcast();
    }
}
