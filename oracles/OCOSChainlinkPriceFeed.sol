// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface AggregatorV3Interface {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundID,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

contract OCOSChainlinkPriceFeed {
    address public owner;

    // Chainlink Aggregator interfaces
    AggregatorV3Interface public bnbUsdPriceFeed;
    AggregatorV3Interface public ocosBnbPriceFeed;

    event PriceFeedsUpdated(address bnbUsd, address ocosBnb);

    constructor(address _bnbUsd, address _ocosBnb) {
        owner = msg.sender;
        bnbUsdPriceFeed = AggregatorV3Interface(_bnbUsd);
        ocosBnbPriceFeed = AggregatorV3Interface(_ocosBnb);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function updatePriceFeeds(address _bnbUsd, address _ocosBnb) external onlyOwner {
        bnbUsdPriceFeed = AggregatorV3Interface(_bnbUsd);
        ocosBnbPriceFeed = AggregatorV3Interface(_ocosBnb);
        emit PriceFeedsUpdated(_bnbUsd, _ocosBnb);
    }

    function getOCOSUsdPrice() external view returns (uint256) {
        (, int256 bnbUsd,,,) = bnbUsdPriceFeed.latestRoundData();
        (, int256 ocosBnb,,,) = ocosBnbPriceFeed.latestRoundData();

        require(bnbUsd > 0 && ocosBnb > 0, "Invalid oracle data");

        // OCOS/USD = OCOS/BNB * BNB/USD
        uint256 price = (uint256(ocosBnb) * uint256(bnbUsd)) / 1e8;
        return price;
    }

    function getRawPrices() external view returns (int256 ocosBnb, int256 bnbUsd) {
        (, bnbUsd,,,) = bnbUsdPriceFeed.latestRoundData();
        (, ocosBnb,,,) = ocosBnbPriceFeed.latestRoundData();
    }
}
