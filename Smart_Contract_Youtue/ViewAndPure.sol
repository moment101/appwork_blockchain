// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// View:  only read state variable
// Pure:  didn't read / write state variable
// modified state variable --> didn't need state mutability

contract A {
    string name;

    function a() external view returns (string memory) {
        return name;
    }

    function b() external pure returns (string memory) {
        return "something";
    }

    function c(string memory _n) external {
        name = _n;
    }
}
