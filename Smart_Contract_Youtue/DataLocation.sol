// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Data Locations - storage, memory,
// calldata (only can use by function input, ready only, save gas)
// memory vs calldata, memory will copy data cost more gas than calldata.

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function example1(
        // 84043 gas
        uint[] memory y,
        string memory s
    ) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");
        MyStruct storage myStruct = myStructs[msg.sender]; // Create storage reference, will change the value of storage variable.
        myStruct.text = "foo";

        MyStruct memory mStruct = myStructs[msg.sender]; // Copy storage value to memory, will not change the value over storage variable.
        mStruct.foo = 456;

        _internalMemory(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    }

    function _internalMemory(uint[] memory y) private {
        uint x = y[0];
    }

    function example2(
        // 42968
        uint[] calldata y,
        string calldata s
    ) external returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct(123, "bar");
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "foo";

        MyStruct memory mStruct = myStructs[msg.sender];
        mStruct.foo = 456;

        _internalCalldata(y);

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        return memArr;
    }

    function _internalCalldata(uint[] calldata y) private {
        uint x = y[0];
    }
}
