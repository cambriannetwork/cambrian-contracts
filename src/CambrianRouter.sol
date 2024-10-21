pragma solidity ^0.8.20;

import {Request, Register} from "./Cambrian.sol";

contract CambrianRouter {
    mapping(address => string) public queries;
    mapping(address => uint256) public nonce;

    function register(string calldata query) public {
        require(bytes(queries[msg.sender]).length == 0, "Already registered");
        queries[msg.sender] = query;
        emit Register(msg.sender, query);
    }

    function execute(uint64 startBlock, uint64 endBlock) public returns (uint256) {
        require(bytes(queries[msg.sender]).length != 0, "Not registered");

        uint256 messageId = nonce[msg.sender]++;

        emit Request(msg.sender, messageId, startBlock, endBlock, queries[msg.sender]);

        return messageId;
    }
}
