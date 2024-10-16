pragma solidity ^0.8.20;

import {Request} from "./Cambrian.sol";

contract CambrianRouter {

    mapping(address => uint256) public nonce;

    function execute(string memory query, uint64 startBlock, uint64 endBlock) public returns (uint256) {

        uint256 messageId = nonce[msg.sender]++;

        emit Request(
            msg.sender, messageId, startBlock, endBlock, query
        );

        return messageId;
    }
}
