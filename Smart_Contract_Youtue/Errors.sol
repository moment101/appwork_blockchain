// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// require, revert, assert
// gas refund
// custom error - save gas
// revert 在複雜的條件判斷下，比較

contract Error {
    function testRequre(uint _i) public pure {
        require(_i <= 10, "i > 10");
        // code
    }

    function testRevert(uint _i) public pure {
        if (_i > 10) {
            revert("i > 10");
        }
        // code
    }

    uint public num = 123;

    function testAssert() public view {
        assert(num == 123);
        // code
    }

    error WrongNum(uint);

    function testCustomError(uint _i) public pure {
        if (_i == 777) {
            revert WrongNum(_i);
        }
        // code
    }
}
