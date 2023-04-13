// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionTest {
    uint public myVariable = 100;

    // pure -> function memory variables
    // view -> check block chain variables
    function returnMany() public pure returns (uint, bool, uint) {
        return (1, true, 2);
    }

    function returnManyV2() public view returns (uint, bool, uint) {
        return (myVariable, true, 2);
    }

    // define name for returns
    function returnManyV3() public view returns (uint a, bool b, uint c) {
        a = myVariable;
        b = true;
        c = 123;
    }

    // destruct
    function returnManyV4() public view returns (uint, bool, uint, uint, uint) {
        (uint a, bool b, uint c) = returnMany();
        (uint d, , uint e) = returnManyV2();
        return (a, b, c, d, e);
    }
}
