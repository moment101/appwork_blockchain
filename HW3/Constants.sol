// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Constants {
    address public constant MY_ADDRESS = address(1); // 378 gas
    uint public constant MY_UINT = 123;
}

contract Var {
    address public MY_ADDRESS = address(1); // 2489 gas
}
