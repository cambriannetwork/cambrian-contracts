pragma solidity ^0.8.20;

import {CambrianRouter} from "../CambrianRouter.sol";

interface ICambrianClient {
    struct Log {
        uint64 blockNumber;
        bytes32 transaction;
        address from;
        address to;
        address contractAddress;
    }

    function register(string memory _query) public;

    function execute(uint256 queryId, uint64 startBlock, uint64 endBlock) public returns (uint256);

    function handleSuccess(uint256 messageId, bytes memory data, Log[] calldata logs) external;

    function handleStatus(uint256 messageId, uint8 status, string calldata message) external;
}
