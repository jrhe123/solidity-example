// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library LibTest {
    // no variable

    function dummy(uint _num) internal pure returns (uint) {
        return _num + 123;
    }
}
