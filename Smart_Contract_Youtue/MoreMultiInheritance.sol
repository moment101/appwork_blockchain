// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
  A     B
/   \  /
C    D
 \  /
   E
*/

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

contract C is A {
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }

    function bar() public pure virtual override returns (string memory) {
        return "C";
    }

    function c() public pure returns (string memory) {
        return "c";
    }
}

contract D is A, B {
    function foo() public pure virtual override(A, B) returns (string memory) {
        return "D";
    }

    function bar() public pure virtual override(A, B) returns (string memory) {
        return "D";
    }

    function d() public pure returns (string memory) {
        return "d";
    }
}

contract E is C, D {
    function foo() public pure virtual override(C, D) returns (string memory) {
        return "E";
    }

    function bar() public pure virtual override(C, D) returns (string memory) {
        return "E";
    }

    function e() public pure returns (string memory) {
        return "e";
    }
}
