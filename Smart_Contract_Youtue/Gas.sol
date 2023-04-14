// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//           noCache.     Cache
// n = 5.     4864        4347
// n = 10.    7224        6207
// n = 100.  49704       39687

contract SaveGas {
    uint public n = 100;

    function noCache() external view returns (uint) {
        uint s = 0;
        for (uint i = 0; i < n; i++) {
            s += 1;
        }
        return s;
    }

    function cache() external view returns (uint) {
        uint _n = n;
        uint s = 0;
        for (uint i = 0; i < _n; i++) {
            s += 1;
        }
        return s;
    }
}
