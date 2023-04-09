// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./025SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public array;

    function createSimpleStorage() public {
        array.push(new SimpleStorage());
    }

    // interact with other contracts
    // 1: address
    // 2: ABI: application binary interface
    function sfStore(uint _index, uint _data) public {
        array[_index].store(_data);
    }

    function sfRetrieve(uint _index) public view returns (uint) {
        return array[_index].retrieve();
    }
}
