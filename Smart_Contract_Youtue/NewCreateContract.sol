// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Account {
    address owner;

    constructor(address _owner) payable {
        owner = _owner;
    }
}

contract AccountFactory {
    Account[] accounts;

    function createAccount(address _owner) external payable {
        Account account = new Account{value: msg.value}(_owner);
        accounts.push(account);
    }
}
