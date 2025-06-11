// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title OCOS Liquidity Oracle for Binance Integration
/// @notice Provides real-time OCOS token liquidity data for CEX-DEX synchronization
/// @dev Emits events for monitoring by off-chain oracles or dashboards

interface ILiquidityManager {
    function getOCOSReserves() external view returns (uint256 ocosAmount, uint256 pairedAssetAmount);
}

contract OCOSLiquidityOracle {
    address public owner;
    ILiquidityManager public liquidityManager;

    event LiquiditySnapshot(
        uint256 timestamp,
        uint256 ocosReserve,
        uint256 pairedReserve,
        string source
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(address _liquidityManager) {
        owner = msg.sender;
        liquidityManager = ILiquidityManager(_liquidityManager);
    }

    /// @notice Triggers a snapshot of current OCOS liquidity
    /// @dev Called periodically by Chainlink Keepers or admin wallet
    function snapshotLiquidity(string memory source) external onlyOwner {
        (uint256 ocos, uint256 paired) = liquidityManager.getOCOSReserves();
        emit LiquiditySnapshot(block.timestamp, ocos, paired, source);
    }

    /// @notice Updates the liquidity manager contract if migrated
    function updateLiquidityManager(address newManager) external onlyOwner {
        liquidityManager = ILiquidityManager(newManager);
    }

    /// @notice Transfers contract ownership
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Zero address");
        owner = newOwner;
    }
}
