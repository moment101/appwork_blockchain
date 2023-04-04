// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    struct Person {
        string name;
        uint8 age;
    }

    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    function enterWithoutModifier() external view {
        require(msg.sender == _owner);
        // code
    }

    // Base
    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    function enterWithModifier() external view onlyOwner {
        // code
    }

    function above18(Person memory p) external pure {
        require(p.age >= 18);
        // code
    }

    // Take parameter
    modifier above18Modifier(Person memory p) {
        require(p.age >= 18);
        _;
    }

    function watchMovie(Person memory p) external view above18Modifier(p) {
        // code
    }

    // Sandwich
    event Log(string message);

    bool private lock;
    modifier noReenter() {
        require(!lock); // before
        lock = true;
        emit Log("before");
        _; // caller body
        lock = false; // after
        emit Log("afer");
    }

    function dangerousFunction() external noReenter {
        // code
        emit Log("body");
    }
}
