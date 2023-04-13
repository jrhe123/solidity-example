// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionModifierTest {
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        // owner addr set to contract deployer
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not owner");
        _; // <- main func
    }

    modifier validateAddress(address _addr) {
        require(_addr != address(0), "invalid address");
        _; // <- main func
    }

    modifier noReEntrancy() {
        require(!locked, "No re-entry");
        locked = true;
        _; // <- main func
        locked = false;
    }

    // multiple modifier
    function modifyOwner(
        address _addr
    ) public onlyOwner validateAddress(_addr) {
        owner = _addr;
    }

    function decrement(uint i) public noReEntrancy {
        x -= i;
        if (i > 1) {
            decrement(i - 1);
        }
    }
}
