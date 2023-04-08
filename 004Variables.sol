pragma solidity ^0.8.17;

contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    int8 public max = type(int8).max;
    int8 public min = type(int8).min;

    function doSomething() public view returns (uint) {
        // Local variables are not saved to the blockchain.
        uint i = 456;

        // Here are some global variables
        uint timestamp = block.timestamp; // Current block timestamp
        address sender = msg.sender; // address of the caller

        return 123;
    }
}
