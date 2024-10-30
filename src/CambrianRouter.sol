pragma solidity ^0.8.20;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CambrianRouter is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    event Request(
        address indexed senderContract, uint256 indexed messageId, uint64 startBlock, uint64 endBlock, string query
    );

    event Register(address indexed senderContract, string query);

    mapping(address => string) public queries;
    mapping(address => uint256) public nonce;

    // Storage GAP
    uint256[49] private __gap;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

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
