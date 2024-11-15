pragma solidity ^0.8.20;

import {ICambrianClient} from "./interfaces/ICambrianClient.sol";

/**
 * @title CambrianClient
 * @notice Example for Client contract
 */
contract CambrianClient is ICambrianClient {
    CambrianRouter public router;

    // Status of a query
    mapping(uint256 => uint8) public status;

    event Status(uint256 indexed messageId, uint8 status, string message);

    constructor(CambrianRouter _router) {
        router = _router;
    }

    /**
     * @notice Register query to Cambrian Router
     * @param _query Query string
     */
    function register(string memory _query) public {
        router.register(_query);
    }

    /**
     * @notice Execute query with given queryId, startBlock, endBlock
     * @param queryId Query ID
     * @param startBlock Start block
     * @param endBlock End block
     * @return Message ID
     */
    function execute(uint256 queryId, uint64 startBlock, uint64 endBlock) public returns (uint256) {
        return router.execute(queryId, startBlock, endBlock);
    }

    function getQueryFormatList() public view returns (string[] memory) {
        return router.queryFormat(msg.sender);
    }

    /**
     * @notice Router callback for success response
     * @param messageId Message ID
     * @param data Response data
     * @param logs Logs
     */
    function handleSuccess(uint256 messageId, uint256 queryId, bytes memory data, Log[] calldata logs) external {
        handleStatus(messageId, 1, "Success");

        // TODO: Handle success response with data and logs based on queryId
    }

    /**
     * @notice Handle status response from Cambrian Router
     * @param messageId Message ID
     * @param status Status
     * @param message Message
     */
    function handleStatus(uint256 messageId, uint8 status, string calldata message) external {
        status[messageId] = status;

        emit Status(messageId, status, message);
    }
}
