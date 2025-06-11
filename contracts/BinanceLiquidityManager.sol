// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title BinanceLiquidityManager
/// @notice Manages OCOS liquidity operations connected to Binance bridge
/// @dev Includes basic liquidity pool sync and reserve status reporting

contract BinanceLiquidityManager is Ownable {
    IERC20 public ocosToken;
    address public reserveVault;
    address public binanceBridge;

    uint256 public totalLiquidityProvided;
    uint256 public lastSynced;

    event LiquidityAdded(uint256 amount, uint256 timestamp);
    event LiquiditySynced(uint256 amount, uint256 timestamp);
    event ReserveVaultUpdated(address newVault);
    event BinanceBridgeUpdated(address newBridge);

    modifier onlyBridge() {
        require(msg.sender == binanceBridge, "Not authorized: Binance Bridge only");
        _;
    }

    constructor(address _token, address _vault, address _bridge) {
        require(_token != address(0), "Invalid OCOS token address");
        require(_vault != address(0), "Invalid reserve vault address");
        require(_bridge != address(0), "Invalid bridge address");

        ocosToken = IERC20(_token);
        reserveVault = _vault;
        binanceBridge = _bridge;
    }

    /// @notice Adds liquidity from the owner wallet to the reserve vault
    function addLiquidity(uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than 0");

        ocosToken.transferFrom(msg.sender, reserveVault, amount);
        totalLiquidityProvided += amount;

        emit LiquidityAdded(amount, block.timestamp);
    }

    /// @notice Called by BinanceBridge to sync liquidity
    function syncLiquidity(uint256 amount) external onlyBridge {
        require(amount > 0, "Invalid sync amount");

        totalLiquidityProvided += amount;
        lastSynced = block.timestamp;

        emit LiquiditySynced(amount, lastSynced);
    }

    /// @notice Updates the reserve vault address
    function updateReserveVault(address newVault) external onlyOwner {
        require(newVault != address(0), "Invalid address");
        reserveVault = newVault;
        emit ReserveVaultUpdated(newVault);
    }

    /// @notice Updates the bridge address (Binance)
    function updateBinanceBridge(address newBridge) external onlyOwner {
        require(newBridge != address(0), "Invalid address");
        binanceBridge = newBridge;
        emit BinanceBridgeUpdated(newBridge);
    }

    /// @notice Returns total provided liquidity and last sync time
    function getLiquidityStatus() external view returns (uint256 liquidity, uint256 lastSync) {
        return (totalLiquidityProvided, lastSynced);
    }
}
