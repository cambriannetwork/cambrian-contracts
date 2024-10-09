// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Client} from "../Client.sol";
import {CambrianRouter} from "../../lib/CambrianRouter.sol";
import {ClientBase} from "../../lib/ClientBase.sol";

contract ClientTest is Test {
    Client public client;
    CambrianRouter public router;

    function setUp() public {
        router = new CambrianRouter();
        client = new Client(router);
    }

    function test_flow() public {
        bytes32 messageId = client.execute();

        ClientBase.Report memory report = ClientBase.Report({content: "0x00"});

        Client.SwapEvent memory swapEvent = Client.SwapEvent({
            sender: address(0xE37e799D5077682FA0a244D46E5649F71457BD09),
            recipient: address(0xE37e799D5077682FA0a244D46E5649F71457BD09),
            amount0: 0x0000000000000000000000000000000000000000000000006f05b59d3b200000,
            amount1: 0x0000000000000000000000000000000000000000000000006f05b59d3b200000,
            sqrtPriceX96: uint160(1607376803801126393653488682667024),
            liquidity: uint128(9225382189131081185),
            tick: int24(
                0x00000000000000000000000000000000000000000000000000000000000306dd
            )
        });

        Client.SwapEvent[] memory events = new Client.SwapEvent[](2);
        events[0] = swapEvent;
        events[1] = swapEvent;

        bytes memory data = abi.encode(events);

        console.logBytes(data);

        client.handleSuccess(messageId, data, report);
    }
}
