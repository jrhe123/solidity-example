// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract PetrolExchange {
    address public owner;
    mapping(address => uint) public petrolBalances;

    // constructor
    constructor() {
        owner = msg.sender;
        petrolBalances[address(this)] = 1000;
    }

    // modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    modifier enoughPetrol(uint amount) {
        require(
            amount <= petrolBalances[address(this)],
            "Not enough petrol left"
        );
        _;
    }

    modifier enoughBalanceToBuyPetrol(uint amount) {
        uint petrolPrice = 0.01 ether;
        require(
            msg.value >= amount * petrolPrice,
            "Your balance is insufficient to buy"
        );
        _;
    }

    /**
     * check petrol balance in contract
     */
    function checkBalance() public view returns (uint) {
        return petrolBalances[address(this)];
    }

    /**
     * add petrol into balance
     */
    function addPetrol(uint amount) public onlyOwner {
        petrolBalances[address(this)] += amount;
    }

    /**
     * buy petrol
     */
    function buyPetrol(
        uint amount
    ) public payable enoughPetrol(amount) enoughBalanceToBuyPetrol(amount) {
        // CALL: send money
        uint petrolPrice = 0.01 ether;
        (bool callSuccess, ) = payable(address(this)).call{
            value: amount * petrolPrice
        }("");
        require(callSuccess, "CALL: send money failed");

        petrolBalances[address(this)] -= amount;
        petrolBalances[msg.sender] += amount;
    }
}
