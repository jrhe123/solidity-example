pragma solidity ^0.8.13;

contract Primitives {
    // default false
    bool public boo;

    // range: 0 <-> 2**8 - 1 (256)
    uint8 public numa = 255;

    // range: 0 <-> 2**16 - 1 (65536)
    uint16 public numb = 65535;

    // 2**256 - 1
    uint public numc = 5654598944;

    // min: -2**7
    // max: 2**7-1
    int8 public numi = -128;
    int8 public numi2 = 127;

    // min: -2**256
    // max: 2**255-1
    int public numi3 = 2 ** 255 - 1;

    // account addr
    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    //
    bytes1 public a = 0x9b;
}
