// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

struct People {
    uint age;
    string name;
}

contract SimpleStorage {
    uint favoriteNumber;
    People[] public peopleArr;
    mapping(string => uint) public nameToAge;

    // virtual: allow to override
    function store(uint _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint) {
        return favoriteNumber;
    }

    // calldata: not mutable
    // memory: can mutate during the func
    // types needs memory: struct/mapping/array
    // * string is array
    function addPeople(uint _age, string calldata _name) public {
        peopleArr.push(People(_age, _name));
        nameToAge[_name] = _age;
    }
}
