// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    // immutalbe gas 364
    // without immutable gas 2500
    // address immutable owner = msg.sender;  // can initialize this way or in constructor
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
