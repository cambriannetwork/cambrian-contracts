pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {ClientBase} from "../lib/ClientBase.sol";
import {Cambrian} from "../lib/Cambrian.sol";
import {IClient} from "../lib/IClient.sol";
import {CambrianRouter} from "../lib/CambrianRouter.sol";

contract Client is ClientBase, Ownable, IClient {
    using Cambrian for Cambrian.Query;

    mapping(bytes32 => uint8) messages;

    struct SwapEvent {
        address sender;
        address recipient;
        int256 amount0;
        int256 amount1;
        uint160 sqrtPriceX96;
        uint128 liquidity;
        int24 tick;
    }

    constructor(CambrianRouter router)
        Ownable(msg.sender)
        ClientBase(router, Cambrian.Query(1, 0x4585FE77225b41b697C938B018E2Ac67Ac5a20c0, "0xFC4321", "last 20"))
    {}

    function executeQuery() external onlyOwner returns (bytes32) {
        bytes32 messageId = execute();
        messages[messageId] = 0;
        return messageId;
    }

    function handleSuccess(bytes32 messageId, Cambrian.Event[] memory events, Report calldata report)
        external
        override
    {
        // to be overrided by custom app
        // e.g loop through events and do something
        for (uint256 i = 0; i < events.length; i++) {
            SwapEvent memory swapEvent = abi.decode(events[i].data, (SwapEvent));
        }
    }

    function handleStatus(bytes32 messageId, Report calldata report) external override {
        // to be overrided by custom app
        // handle errors also
    }
}
