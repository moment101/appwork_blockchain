// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FunctionOutputs {
    function returnMany() public pure returns (uint, bool) {
        // 479 gas
        return (1, true);
    }

    function named() public pure returns (uint x, bool b) {
        // 457 gas
        return (1, true);
    }

    function asigned() public pure returns (uint x, bool b) {
        // 501 gas
        x = 1;
        b = true;
    }

    function destructingAssignments() public pure {
        (uint x, bool b) = returnMany();
        (, bool _b) = returnMany();
    }
}

// gas cost is different from video https://www.youtube.com/watch?v=je7dWT6bEZM
// video say asigned will save a little gas
