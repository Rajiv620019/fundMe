// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
// To get the price of ETH using chainlink
    function getPrice() internal view returns (uint) {
        // Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface price = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int cost,,,) = price.latestRoundData();
        return uint(cost * 1e10);
    }

    function getVersion() internal view returns (uint) {
        AggregatorV3Interface price = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return price.version();
    }

    // Converting the ETH to USD
    function conversionRate(uint ethAmount) internal view returns (uint) {
        uint ethPrice = getPrice();
        uint ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
}
