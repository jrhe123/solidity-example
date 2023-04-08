// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract IfElseTest {
    // pure / view no gas needs
    function foo(uint abc) public pure returns (uint) {
        if (abc < 10) {
            return 0;
        } else if (abc < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternary(uint abc) public pure returns (uint) {
        return abc < 10 ? 1 : 2;
    }
}
