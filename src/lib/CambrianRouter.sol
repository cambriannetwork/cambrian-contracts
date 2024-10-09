pragma solidity ^0.8.20;

import {Cambrian} from "./Cambrian.sol";

contract CambrianRouter {
    using Cambrian for Cambrian.Query;

    event RequestQuery(
        address indexed senderContract,
        bytes32 indexed messageId,
        uint256 chainId,
        address contractAddress,
        string eventIdentifier,
        string query
    );

    function execute(Cambrian.Query memory query) public returns (bytes32) {
        bytes32 messageId = keccak256(abi.encodePacked(query.query));

        emit RequestQuery(
            msg.sender, messageId, query.chainId, query.contractAddress, query.eventIdentifier, query.query
        );

        return messageId;
    }
}
