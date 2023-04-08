// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract NestMapTest {
    mapping(address => mapping(uint => bool)) public myMap;

    function getBool(address _addr, uint _num) public view returns (bool) {
        return myMap[_addr][_num];
    }

    function setBool(address _addr, uint _num, bool _boo) public {
        myMap[_addr][_num] = _boo;
    }

    function delBool(address _addr, uint _num) public {
        delete myMap[_addr][_num];
    }
}
