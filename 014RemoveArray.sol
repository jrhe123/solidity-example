// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract RemoveArrayTest {
    uint[] public Arr = [1, 2, 3, 4, 5, 6];

    function remove(uint _index) public {
        require(_index < Arr.length, "the index is greater than array length");

        for (uint i = _index; i < Arr.length - 1; i++) {
            Arr[i] = Arr[i + 1];
        }

        Arr.pop();
    }

    function getArray() public view returns (uint[] memory) {
        return Arr;
    }

    function test() external {
        remove(2);
        assert(Arr[0] == 1);
        assert(Arr[1] == 2);
        assert(Arr[2] == 4);
        assert(Arr.length == 4);
    }
}
