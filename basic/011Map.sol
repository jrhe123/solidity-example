// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MapTest {
    // Key => Value
    // key type: string, bool, int, address, bytes, contract
    // value type: any or mapping or array

    mapping(address => uint) public myMap;

    function getByAddr(address _addr) public view returns (uint) {
        // if not exists, return 0
        return myMap[_addr];
    }

    function setAddr(address _addr, uint _i) public {
        myMap[_addr] = _i;
    }

    function delAddr(address _addr) public {
        delete myMap[_addr];
    }
}
