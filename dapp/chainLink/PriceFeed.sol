// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// https://docs.chain.link/data-feeds/using-data-feeds
// github link:
// https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// choose: ETH/USD contract
// https://docs.chain.link/data-feeds/price-feeds/addresses

/**
    Goerli Testnet
    
    BTC / ETH
    0x779877A7B0D9E8603169DdbD7836e478b4624789
    BTC / USD
    0xA39434A63A52E749F02807ae27335515BA4b07F7
    CZK / USD
    0xAE45DCb3eB59E27f05C170752B218C6174394Df8
    DAI / USD
    0x0d79df66BE487753B02D015Fb622DED7f0E9798d
    ETH / USD
    0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    EUR / USD
    0x44390589104C9164407A0E0562a9DBe6C24A0E05
    FORTH / USD
    0x7A65Cf6C2ACE993f09231EC1Ea7363fb29C13f2F
    GBP / USD
    0x73D9c953DaaB1c829D01E1FC0bd92e28ECfB66DB
    JPY / USD
    0x982B232303af1EFfB49939b81AD6866B2E4eeD0B
    LINK / ETH
    0xb4c4a493AB6356497713A78FFA6c60FB53517c63
    LINK / USD
    0x48731cF7e84dc94C5f84577882c14Be11a5B7456
    SNX / USD
    0xdC5f59e61e51b90264b38F0202156F07956E2577
    StakeStar PoR
    0xcd3BBd46c6c6354e3B03780F99E9836d3AC7740b
    USDC / USD
    0xAb5c49580294Aff77670F839ea425f5b78ab3Ae7
    XAU / USD
    0x7b219F57a8e9C7303204Af681e9fA69d17ef626f
 */

contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
    }

    /**
     * Returns the latest price.
     */
    function getLatestPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}
