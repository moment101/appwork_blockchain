// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract OperationArray {
    uint[] public arr;

    // [1, 2, 3]   remove(1)   ---> [1, 3, 3]  ---> [1, 3]
    function remove(uint _index) public {
        require(_index < arr.length, "Out of bound");
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    // [1, 2, 3, 4]
    // remove(1)
    // [1, 4, 3, 4]
    // [1, 4, 3]
    // Order is changed;
    function removeByReplace(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1, 2, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // []
        assert(arr.length == 0);
    }

    // [1, 2, 3, 4, 5]
    function addElements() external {
        arr.push(1);
        arr.push(2);
        arr.push(3);
        arr.push(4);
        arr.push(5);
    }

    // Insert Element
    // [1, 2, 3, 4, 5]
    // [1, 2, 3, 4, 5, 0]
    // [1, 2, 3, 3, 4, 5]
    // [1, 2, 9, 3, 4, 5]
    function add(uint _index, uint _newNum) public {
        require(_index < arr.length, "Out of bound");
        arr.push();
        for (uint i = arr.length - 2; i >= _index; i--) {
            arr[i + 1] = arr[i];
            if (i == 0) {
                break;
            }
        }
        arr[_index] = _newNum;
    }

    function testAdd() external {
        arr = [1, 2, 3, 4, 5];
        add(2, 9);

        // [1, 2, 9, 3, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 9);
        assert(arr[3] == 3);
        assert(arr[4] == 4);
        assert(arr[5] == 5);
        assert(arr.length == 6);

        // [1]
        // [1, 0]
        // [1, 1]
        // [5, 1]
        arr = [1];
        add(0, 5);
        assert(arr[0] == 5);
        assert(arr[1] == 1);
        assert(arr.length == 2);
    }
}
