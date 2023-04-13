// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EventTest {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "hello world!!");
        emit AnotherLog();
    }
}
