// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Base {
    event Log(string message);
}

contract A is Base {
    string name;

    constructor(string memory _name) {
        name = _name;
        emit Log("A constructor");
    }
}

contract B is Base {
    string title;

    constructor(string memory _title) {
        title = _title;
        emit Log("B constructor");
    }
}

// A -> B -> C

contract C is A("n"), B("t") {
    string work;

    constructor(string memory _work) {
        work = _work;
        emit Log("C constructor");
    }
}

// B -> A -> D

contract D is B("t"), A("n") {
    string work;

    constructor(string memory _work) {
        work = _work;
        emit Log("D constructor");
    }
}
