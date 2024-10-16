pragma solidity ^0.8.20;

import {CambrianRouter} from "./CambrianRouter.sol";

struct CambrianQuery {
    uint256 chainId;
    address contractAddress;
    string filter;
}

struct CambrianEvent {
    uint64 blockNumber;
    bytes transaction;
    address from;
    address to;
    address contractAddress;
    bytes data;
}

struct Report {
    bytes content;
}
