pragma solidity ^0.8.20;

import {ClientBase} from "./ClientBase.sol";

interface IClient {
    function handleSuccess(bytes32 messageId, bytes memory data, ClientBase.Report calldata report) external;

    function handleStatus(bytes32 messageId, ClientBase.Report calldata report) external;
}
