pragma solidity ^0.8.20;

struct Event {
    uint64 blockNumber;
    bytes32 transaction;
    address from;
    address to;
    address contractAddress;
    bytes data;
}

struct Response {
    uint256 messageId;
    Event[] events;
}

struct Status {
    uint256 messageId;
    uint8 status;
    string message;
}

event Request(
    address indexed senderContract,
    uint256 indexed messageId,
    uint64 startBlock,
    uint64 endBlock,
    string query
);

interface IClient {

    function handleSuccess(Response memory response) external;

    function handleStatus(Status calldata status) external;

}
