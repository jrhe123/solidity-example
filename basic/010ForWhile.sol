// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ForWhileTest {
    function addTotal() public pure returns (uint) {
        uint numa;

        for (uint i = 0; i < 50; i++) {
            if (i < 10) {
                continue;
            }
            if (i == 40) {
                break;
            }
            numa += 1;
        }

        return numa;
    }

    function addTotalV2() public pure returns (uint) {
        uint numa;

        uint counter;
        while (counter < 10) {
            numa += counter;
            counter++;
        }

        return numa;
    }
}
