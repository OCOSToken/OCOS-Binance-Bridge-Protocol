// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title OwnableExtended - OCOS protocol ownership extension
/// @notice Extends OpenZeppelin Ownable for multi-tier access & emergency controls
/// @dev This contract is part of OCOS-Binance-Bridge-Pro

abstract contract OwnableExtended {
    address private _owner;
    address private _pendingOwner;
    mapping(address => bool) private _operators;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OperatorAdded(address indexed operator);
    event OperatorRemoved(address indexed operator);
    event OwnershipTransferInitiated(address indexed from, address indexed to);

    modifier onlyOwner() {
        require(owner() == msg.sender, "OwnableExtended: caller is not the owner");
        _;
    }

    modifier onlyOperator() {
        require(_operators[msg.sender], "OwnableExtended: caller is not an operator");
        _;
    }

    constructor() {
        _transferOwnership(msg.sender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function pendingOwner() public view returns (address) {
        return _pendingOwner;
    }

    function isOperator(address account) public view returns (bool) {
        return _operators[account];
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "OwnableExtended: new owner is the zero address");
        _pendingOwner = newOwner;
        emit OwnershipTransferInitiated(_owner, newOwner);
    }

    function acceptOwnership() public {
        require(msg.sender == _pendingOwner, "OwnableExtended: not pending owner");
        _transferOwnership(_pendingOwner);
        _pendingOwner = address(0);
    }

    function addOperator(address operator) public onlyOwner {
        require(operator != address(0), "OwnableExtended: invalid operator");
        _operators[operator] = true;
        emit OperatorAdded(operator);
    }

    function removeOperator(address operator) public onlyOwner {
        require(_operators[operator], "OwnableExtended: not an operator");
        _operators[operator] = false;
        emit OperatorRemoved(operator);
    }

    function renounceOwnership() public onlyOwner {
        _transferOwnership(address(0));
    }

    function _transferOwnership(address newOwner) internal {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
