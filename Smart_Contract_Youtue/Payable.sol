// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
