// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FallbackTest {
    //
    uint public test = 0;

    receive() external payable {
        test = 1;
    }

    fallback() external payable {
        test = 2;
    }
}
