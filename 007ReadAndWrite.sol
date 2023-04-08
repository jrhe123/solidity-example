pragma solidity ^0.8.17;

contract SimpleStorage {
    uint public numa;

    function set(uint _num) public {
        numa = _num;
    }

    function get() public view returns (uint) {
        return numa;
    }
}
