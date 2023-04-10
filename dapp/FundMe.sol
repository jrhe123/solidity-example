// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
  1. donate
  2. withdraw donation
  3. display people donated
  4. minimum amount: 100usd
 */
contract FundMe {
    address public owner;
    uint minimumUSD = 100;
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        owner = msg.sender;
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
    }

    function getLatestPrice() public view returns (uint) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint(price);
    }

    // input unit is "wei"
    function ethToUSD(uint ethAmount) public view returns (uint) {
        uint ethPrice = getLatestPrice();
        // ethPrice / 1e8
        // ethAmount / 1e18 (wei -> ether)
        uint ethInUSD = (ethPrice * ethAmount) / 1e26;
        return ethInUSD;
    }

    // payable
    function fund() public payable {
        require(
            ethToUSD(msg.value) > minimumUSD,
            "Amount must be greater than 100 USD!"
        );
        // not unit => means wei
        // 1 ether = 10**18 wei = 10**9 Gwei = 1e18
    }

    function withdraw() public {
        require(msg.sender == owner, "Not contract deployer!");
    }
}
