// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    function sumFor(uint _n) external pure returns (uint) {
        // n=10 gas=4342  n=1000 gas=369652
        uint s = 0;
        for (uint i = 1; i <= _n; i++) {
            s += i;
        }
        return s;
    }

    function sumWhile(uint _n) external pure returns (uint) {
        // n=10 gas=4320  n=1000 gas=369630
        uint s = 0;
        uint i = 1;
        while (i <= _n) {
            s += i;
            i++;
        }
        return s;
    }
}
