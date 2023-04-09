// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ReplaceArrayTest {
    uint[] public arr = [1, 2, 3, 4, 5, 6];

    function removeByIndex(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function get() public view returns (uint[] memory) {
        return arr;
    }
}
