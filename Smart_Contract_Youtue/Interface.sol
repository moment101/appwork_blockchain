// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract A {
    uint public num;

    function inc() external {
        num++;
    }

    function getNum() external view returns (uint) {
        return num;
    }
}

// use interface when you don't have the other contract source code
// interface func name should be the identical
interface ICA {
    function inc() external;

    function getNum() external view returns (uint);
}

contract CallA {
    function inc(address _ica) external {
        ICA(_ica).inc();
    }

    function getNum(ICA _ica) external view returns (uint) {
        return ICA(_ica).getNum();
    }
}
