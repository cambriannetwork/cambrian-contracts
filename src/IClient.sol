pragma solidity ^0.8.20;

import {ClientBase} from "./ClientBase.sol";
import {CambrianEvent, Report} from "./Cambrian.sol";

interface IClient {
    function handleSuccess(
        bytes32 messageId,
        CambrianEvent[] memory events,
        Report calldata report
    ) external;

    function handleStatus(bytes32 messageId, Report calldata report) external;
}
