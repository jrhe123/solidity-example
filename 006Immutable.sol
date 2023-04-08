pragma solidity ^0.8.13;

contract ImmutableTest {
    // immutable only allowed to define in constructor
    address public immutable MY_ADDR;
    uint public immutable MY_UINT;

    constructor(uint _myUnit) {
        // msg.data
        // msg.gas
        // msg.sender
        // msg.sig
        // msg.value
        MY_ADDR = msg.sender;
        MY_UINT = _myUnit;
    }
}
