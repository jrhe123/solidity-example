// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./027Library.sol";

error NotOwner();

/**
  1. donate
  2. withdraw donation
  3. display people donated
  4. minimum amount: 100usd
 */
contract FundMe {
    // using: use library
    using LibTest for uint256;
    // immutable: reduce gas
    address public immutable i_owner;
    // constant: reduce gas
    uint constant minimumUSD = 100;
    AggregatorV3Interface internal priceFeed;
    //
    address[] public funders;
    mapping(address => uint) public addressToETHAmountFounded;

    modifier onlyOwner() {
        // reduce gas:
        // require(msg.sender == i_owner, "Not contract deployer!");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        // use library defined function
        uint dummy = 123.dummy(20);
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

        // record funder list
        funders.push(msg.sender);
        addressToETHAmountFounded[msg.sender] = msg.value;
    }

    // withdraw the contract's balance
    // https://solidity-by-example.org/sending-ether/
    function withdraw() public onlyOwner {
        // THREE WAY to send money
        // 1. call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "CALL failed");

        // 2. transfer
        // payable(msg.sender).transfer(address(this).balance);

        // 3. send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "transaction failed");

        // reset
        for (uint i = 0; i < funders.length; i++) {
            addressToETHAmountFounded[funders[i]] = 0;
        }
        funders = new address[](0);
    }

    // low level interactions: not using "fund"
    // to receive ETH through contract's address directly
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
