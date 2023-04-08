// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    // get min/max by using type
    int8 public max = type(int8).max;
    int8 public min = type(int8).min;

    // 1. local variable: stored in function ram
    // 2. block chain variable: stored in chain (needs gas)
    // 3. global variable: global variable (ETH)

    // e.g., stored in block chain
    string public myName = "Hello world!!";

    function doSomething() public view returns (uint, address) {
        // e.g., local variables are not saved to the blockchain.
        uint i = 456;

        // block.timestamp
        // block.number
        // block.gaslimit
        // block.difficulty
        // block.coinbase
        // block.blockhash(blockNumber);

        // e.g., global variables
        uint timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller

        return (timestamp, sender);
    }
}
