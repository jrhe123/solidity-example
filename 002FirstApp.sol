// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Counter {
    // default 0
    uint public count;

    function get() public view returns (uint) {
        return count;
    }

    function increment() public {
        count++;
    }

    function decrement() public {
        count--;
    }
}
