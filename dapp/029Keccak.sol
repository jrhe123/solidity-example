// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract KeccakTest {
    uint hashdigit = 8;
    uint hashmodule = 10 ** hashdigit;

    function generateRandom(string memory _str) public view returns (uint) {
        uint random = uint(keccak256(abi.encodePacked(_str)));
        return random % hashmodule;
    }
}
