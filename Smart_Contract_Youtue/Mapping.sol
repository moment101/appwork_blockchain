// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint) public balance;
    mapping(address => mapping(address => bool)) public isFriend;

    function examples() external {
        balance[msg.sender] = 123;
        uint bal = balance[msg.sender];
        uint bal2 = balance[address(1)]; // 0

        balance[msg.sender] += 456; // 123 + 456 = 579
        delete balance[msg.sender]; // 0

        isFriend[msg.sender][address(this)];
    }
}
