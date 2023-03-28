// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function textMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}
