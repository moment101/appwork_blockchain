// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// self destruct
// force send ethr to any address
// selfdestruct has been deprecated. The underlying opcode will eventually undergo breaking changes.

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function test() external pure returns (uint) {
        return 123;
    }
}

contract Help {
    constructor() payable {}

    function callKiller(Kill _kill) external {
        _kill.kill();
    }
}
