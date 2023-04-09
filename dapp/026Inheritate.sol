// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./025SimpleStorage.sol";

contract InheritateTest is SimpleStorage {
    // add new func
    function foo() public {
        uint abc = 123;
    }

    // Override func
    function store(uint _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 10;
    }
}
