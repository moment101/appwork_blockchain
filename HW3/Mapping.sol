// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint) public balance;
    mapping(address => mapping(address => bool)) public isFriend;
}
