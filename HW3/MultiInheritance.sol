// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
   X
/  |
Y  |
 \ |
   Z
*/

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "X";
    }

    function bar() public pure virtual override returns (string memory) {
        return "X";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    function foo() public pure virtual override(X, Y) returns (string memory) {
        return "Z";
    }

    function bar() public pure virtual override(Y, X) returns (string memory) {
        return "Z";
    }

    function z() public pure returns (string memory) {
        return "Z";
    }
}

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    function a() public pure returns (string memory) {
        return "a";
    }
}

contract B {
    function foo() public pure virtual returns (string memory) {
        return "B";
    }

    function bar() public pure virtual returns (string memory) {
        return "B";
    }

    function b() public pure returns (string memory) {
        return "b";
    }
}

contract C is A, B {
    function foo() public pure virtual override(A, B) returns (string memory) {
        return "C";
    }

    function bar() public pure virtual override(A, B) returns (string memory) {
        return "C";
    }
}
