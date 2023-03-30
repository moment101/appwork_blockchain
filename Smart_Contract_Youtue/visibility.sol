// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// private
// internal
// public
// external

contract A {
    uint private x = 1;
    uint internal y = 2;
    uint public z = 3;

    event Log(string message);

    function privateFunc() private pure {}

    function internalFunc() internal pure {}

    function publicFunc() public pure {}

    function externalFunc() external {
        emit Log("A. external func called");
    }

    function example() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
    }
}

contract B is A {
    function example2() external view {
        y + z;
        internalFunc();
        publicFunc();
    }
}

contract C {
    function callBexternalFunc(address _b) external {
        B(_b).externalFunc();
    }
}
