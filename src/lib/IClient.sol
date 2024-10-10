pragma solidity ^0.8.20;

import {ClientBase} from "./ClientBase.sol";
import {Cambrian} from "./Cambrian.sol";

interface IClient {
    function handleSuccess(bytes32 messageId, Cambrian.Event[] memory events, ClientBase.Report calldata report)
        external;

    function handleStatus(bytes32 messageId, ClientBase.Report calldata report) external;
}
