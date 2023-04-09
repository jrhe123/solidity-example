// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ErrorTest {
    function testError(uint _i) public pure {
        require(_i > 10, "i must be greater than 10");
    }

    function testRevert(uint _i) public pure {
        if (_i <= 10) {
            revert("i must be greater than 10");
        }
    }

    function testAssert() public pure {
        uint num;
        assert(num == 0);
    }
}
