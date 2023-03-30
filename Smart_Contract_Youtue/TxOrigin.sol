// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Base {
    event Log(string message, address who);
}

contract A is Base {
    string name = "AAA";

    function getName() external returns (string memory) {
        emit Log("A tx.origin", tx.origin);
        emit Log("A msg.sender", msg.sender);
        return name;
    }
}

contract B is Base {
    A aContract;

    constructor(address a) {
        aContract = A(a);
    }

    function callAfunc() external {
        emit Log("B tx.origin", tx.origin);
        emit Log("B msg.sender", msg.sender);

        aContract.getName();
    }
}
