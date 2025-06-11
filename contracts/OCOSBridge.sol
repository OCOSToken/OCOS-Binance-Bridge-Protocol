// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title OCOS ↔ Binance Bridge Smart Contract
/// @author OCOS
/// @notice Manages token bridging between Binance CEX and OCOS BEP20 ecosystem

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract OCOSBridge {
    address public admin;
    address public tokenAddress;
    address public binanceProxy;

    event DepositFromBinance(address indexed user, uint256 amount, string txRef);
    event WithdrawToBinance(address indexed user, uint256 amount, string txRef);
    event BinanceProxyUpdated(address oldProxy, address newProxy);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    modifier onlyBinance() {
        require(msg.sender == binanceProxy, "Only Binance proxy");
        _;
    }

    constructor(address _tokenAddress, address _binanceProxy) {
        admin = msg.sender;
        tokenAddress = _tokenAddress;
        binanceProxy = _binanceProxy;
    }

    /// @notice Binance proxy can deposit OCOS to user wallet
    function depositFromBinance(address user, uint256 amount, string calldata txRef) external onlyBinance {
        require(IERC20(tokenAddress).transfer(user, amount), "Transfer failed");
        emit DepositFromBinance(user, amount, txRef);
    }

    /// @notice User requests withdrawal, tokens held by bridge
    function withdrawToBinance(uint256 amount, string calldata txRef) external {
        require(IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount), "TransferFrom failed");
        emit WithdrawToBinance(msg.sender, amount, txRef);
    }

    /// @notice Admin can update Binance proxy
    function updateBinanceProxy(address newProxy) external onlyAdmin {
        emit BinanceProxyUpdated(binanceProxy, newProxy);
        binanceProxy = newProxy;
    }
}
