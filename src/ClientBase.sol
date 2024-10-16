pragma solidity ^0.8.20;

import {CambrianQuery} from "./Cambrian.sol";
import {CambrianRouter} from "./CambrianRouter.sol";

abstract contract ClientBase {
    CambrianQuery public query;
    CambrianRouter public router;

    constructor(CambrianRouter _router, CambrianQuery memory _query) {
        router = _router;
        query = _query;
    }

    function execute(
        uint64 startBlock,
        uint64 endBlock
    ) public returns (bytes32) {
        return router.execute(query, startBlock, endBlock);
    }
}
