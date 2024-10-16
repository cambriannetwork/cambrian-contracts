pragma solidity ^0.8.20;

import {CambrianRouter} from "./CambrianRouter.sol";

abstract contract ClientBase {
    string public query;
    CambrianRouter public router;

    constructor(CambrianRouter _router, string memory _query) {
        router = _router;
        query = _query;
    }

    function execute(uint64 startBlock, uint64 endBlock) public returns (uint256) {
        return router.execute(query, startBlock, endBlock);
    }
}
