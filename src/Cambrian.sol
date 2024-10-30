pragma solidity ^0.8.20;

struct Log {
    uint64 blockNumber;
    bytes32 transaction;
    address from;
    address to;
    address contractAddress;
}

interface IClient {
    function handleSuccess(uint256 messageId, bytes memory data, Log[] calldata logs) external;

    function handleStatus(uint256 messageId, uint8 status, string calldata message) external;
}
