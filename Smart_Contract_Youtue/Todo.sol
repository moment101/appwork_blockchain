// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList {
    struct Todo {
        string name;
        bool completed;
    }
    address private _owner;
    mapping(address => Todo[]) public ownerTodos;

    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function create(string calldata name) external {
        Todo[] storage todos = ownerTodos[msg.sender];
        todos.push(Todo(name, false));
    }

    function update(uint tid, bool completed) external {
        Todo[] storage todos = ownerTodos[msg.sender];
        Todo storage todo = todos[tid];
        todo.completed = completed;
    }

    function get(
        uint tid
    ) external view returns (string memory name, bool completed) {
        Todo[] storage todos = ownerTodos[msg.sender];
        Todo storage todo = todos[tid];
        return (todo.name, todo.completed);
    }

    function kill() external onlyOwner {
        selfdestruct(payable(msg.sender));
    }
}
