// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
calling parent functions
- direct
- super

     E
   /   \
  F     G
  \     /
     H
*/

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        E.bar();
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    // H -> F -> E
    function foo() public virtual override(F, G) {
        emit Log("H.foo");
        F.foo();
    }

    // H, G, F, E
    function bar() public virtual override(F, G) {
        emit Log("H.bar");
        super.bar(); // will call all of his parent function, from near to base
    }
}
