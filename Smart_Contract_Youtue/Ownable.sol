// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    modifier validAddress(address _newAddress) {
        require(_newAddress != address(0), "Address Zero");
        _;
    }

    function setOwner(
        address _newOwner
    ) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() public onlyOwner {
        // code
    }

    function anyoneCanCallThisFunc() public {
        // code
    }
}
