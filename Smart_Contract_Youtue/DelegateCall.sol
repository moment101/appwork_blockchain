// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract A {
    uint public num;
    uint public value;
    address public sender;

    function setVars(uint _num) external payable {
        num = _num;
        value = msg.value;
        sender = msg.sender;
    }
}

contract B {
    uint public num;
    uint public value;
    address public sender;

    function callA(address _a, uint _num) external payable {
        (bool success, ) = _a.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        require(success, "delegate call failed");
    }
}
