pragma solidity ^0.8.20;

import {OwnableUpgradeable} from "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";

/**
 * @title CambrianRouter
 * @notice Router contract for Cambrian
 */
contract CambrianRouter is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    event Register(address indexed senderContract, uint256 indexed queryId, string query);
    event Request(
        address indexed senderContract, uint256 indexed messageId, uint64 startBlock, uint64 endBlock, string query
    );

    mapping(address => uint256) public numQueryFormat;
    mapping(address => mapping(uint256 => string)) public queryFormat;
    mapping(address => uint256) public nonce;

    // Storage GAP
    uint256[49] private __gap;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /**
     * @notice Initialize contract
     * @param initialOwner Initial owner
     */
    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    /**
     * @notice Authorize upgrade
     * @param newImplementation New implementation
     */
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    /**
     * @notice Register query
     * @param query Query
     */
    function register(string calldata query) public {
        queryFormat[msg.sender][++numQueryFormat[msg.sender]] = query;

        emit Register(msg.sender, numQueryFormat[msg.sender], query);
    }

    /**
     * @notice Execute query
     * @param queryId Query ID
     * @param startBlock Start block
     * @param endBlock End block
     * @return Message ID
     */
    function execute(uint256 queryId, uint64 startBlock, uint64 endBlock) public returns (uint256) {
        require(numQueryFormat[msg.sender] != 0, "Error: Address has no query format!");

        emit Request(msg.sender, nonce[msg.sender]++, startBlock, endBlock, queryFormat[msg.sender][queryId]);

        return nonce[msg.sender];
    }
}
