pragma solidity ^0.8.20;

import {Request, Register} from "./Cambrian.sol";

struct wrapper {
    string val;
    bool isValue;
}

contract CambrianRouter {
    mapping(address => wrapper) public queries;
    mapping(address => uint256) public nonce;

    function register(string calldata query) public {
        require(!queries[msg.sender].isValue, "Already registered");
        queries[msg.sender] = wrapper(query, true);
        emit Register(msg.sender, query);
    }

    function execute(uint64 startBlock, uint64 endBlock) public returns (uint256) {
        require(queries[msg.sender].isValue, "Not registered");

        uint256 messageId = nonce[msg.sender]++;

        emit Request(msg.sender, messageId, startBlock, endBlock, queries[msg.sender].val);

        return messageId;
    }
}
