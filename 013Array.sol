// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArrayTest {
    uint[] public array;

    uint[] public array2 = [1, 2, 3, 4, 5];

    // default 0
    uint[5] public array3;

    function get(uint _index) public view returns (uint) {
        return array[_index];
    }

    function getArr() public view returns (uint[] memory) {
        return array;
    }

    function push(uint _item) public {
        array.push(_item);
    }

    function pop() public {
        array.pop();
    }

    function getLength() public view returns (uint) {
        return array.length;
    }

    function deleteByIndex(uint _index) public {
        delete array[_index];
    }

    function createMemoryArray() external pure {
        uint[] memory array = new uint[](5);
    }
}
