// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherAndWeiTest {
    // Wei minimum unit
    // 1 eth = 10**18 Wei

    uint public oneWei = 1 wei;
    bool public isOneWei = (1 wei == 1);

    uint public oneEther = 1 ether;
    bool public isOneEther = (1 ether == 10 ** 18 wei); // 1e18
}
