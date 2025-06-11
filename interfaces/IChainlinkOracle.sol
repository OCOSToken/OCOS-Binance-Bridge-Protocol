// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title IChainlinkOracle
/// @author OCOS Core
/// @notice Interface to interact with Chainlink oracle price feeds
/// @dev Can be implemented to support OCOS/BNB, OCOS/USDT, OCOS/BTC pairs

interface IChainlinkOracle {
    /// @notice Returns the latest price from the Chainlink aggregator
    /// @dev Price should be scaled (usually 8 decimals)
    /// @return price Latest price value
    function getLatestPrice() external view returns (int256 price);

    /// @notice Returns the timestamp of the last update
    /// @return timestamp Unix timestamp of last price update
    function getLastUpdatedTime() external view returns (uint256 timestamp);

    /// @notice Returns the number of decimals the price feed uses
    /// @return decimals Number of decimals
    function getDecimals() external view returns (uint8 decimals);

    /// @notice Returns the address of the underlying Chainlink aggregator
    /// @return aggregator Address of the Chainlink price feed contract
    function getAggregator() external view returns (address aggregator);
}
