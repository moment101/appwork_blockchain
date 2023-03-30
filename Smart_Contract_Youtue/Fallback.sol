// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// fallback will be called
// when
// 1. function doesn't exist
// 2. directly send ether

//            msg.data  is empty
//            /                \
//           Yes               No
//          /                    \
//     receive exist           fallback()
//        /      \
//      Yes       No
//      /          \
//   receive()   fallback()

contract A {
    event Log(string message);

    fallback() external payable {
        emit Log("fallback call");
    }

    receive() external payable {
        emit Log("receive call");
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
