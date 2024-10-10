pragma solidity ^0.8.20;

import {CambrianRouter} from "./CambrianRouter.sol";

library Cambrian {
    struct Query {
        uint256 chainId;
        address contractAddress;
        string eventIdentifier;
        string query;
    }

    struct Event {
        uint64 blockNumber;
        bytes transaction;
        address from;
        address to;
        address contractAddress;
        bytes data;
    }
}
