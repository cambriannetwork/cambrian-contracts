pragma solidity ^0.8.20;

import {CambrianRouter} from "./CambrianRouter.sol";

abstract contract ClientBase {
    CambrianRouter public router;

    constructor(CambrianRouter _router, string memory _query) {
        router = _router;
        router.register(_query);
    }

    function execute(uint64 startBlock, uint64 endBlock) public returns (uint256) {
        return router.execute(startBlock, endBlock);
    }
}
