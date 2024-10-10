// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Client} from "../Client.sol";
import {CambrianRouter} from "../../lib/CambrianRouter.sol";
import {ClientBase} from "../../lib/ClientBase.sol";
import {Cambrian} from "../../lib/Cambrian.sol";

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
            tick: int24(0x00000000000000000000000000000000000000000000000000000000000306dd)
        });

        bytes memory eventData = abi.encode(swapEvent);

        Cambrian.Event memory cambrianEvent = Cambrian.Event({
            blockNumber: 0,
            transaction: "0x00",
            from: address(0xE37e799D5077682FA0a244D46E5649F71457BD09),
            to: address(0x4585FE77225b41b697C938B018E2Ac67Ac5a20c0),
            contractAddress: address(0x4585FE77225b41b697C938B018E2Ac67Ac5a20c0),
            data: eventData
        });

        Cambrian.Event[] memory events = new Cambrian.Event[](2);
        events[0] = cambrianEvent;
        events[1] = cambrianEvent;

        client.handleSuccess(messageId, events, report);
    }
}
