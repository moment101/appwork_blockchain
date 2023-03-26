// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IterableMapping {
    mapping(address => uint) balances;
    mapping(address => bool) inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        balances[_key] = _val;
        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function getFirst() external view returns (uint) {
        return balances[keys[0]];
    }

    function getLast() external view returns (uint) {
        return balances[keys[keys.length - 1]];
    }

    function getTotal() external view returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < keys.length; i++) {
            sum += balances[keys[i]];
        }
        return sum;
    }
}
