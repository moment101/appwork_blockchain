// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Call    https://solidity-by-example.org/call/
// call is a low level function to interact with other contracts.

// This is the recommended method to use when you're just sending Ether via calling the fallback function.

// However it is not the recommend way to call existing functions.

// Few reasons why low-level call is not recommended
// Reverts are not bubbled up
// Type checks are bypassed
// Function existence checks are omitted

contract A {
    event Log(string message);

    constructor() payable {}

    uint public _num;

    function foo(
        string memory message,
        uint num
    ) external payable returns (uint result) {
        _num = num;
        emit Log(message);
        return 5;
    }

    fallback() external payable {
        emit Log("fallback called");
    }

    receive() external payable {
        emit Log("receive called");
    }
}

contract Caller {
    bytes public _data;

    function callExist(address a) external payable {
        (bool success, bytes memory data) = a.call{
            value: msg.value,
            gas: 30000
        }(abi.encodeWithSignature("foo(string,uint256)", "Hello World", 123));
        _data = data;
        require(success, "called failed");
    }

    function callNoneExist(address a) external payable {
        (bool success, bytes memory data) = a.call{
            value: msg.value,
            gas: 50000
        }(abi.encodeWithSignature("bar(string,uint256)", "Hello World", 123));
        _data = data;
        require(success, "called bar failed");
    }
}
