// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        // calldata 80004 gas
        todos.push(Todo({text: _text, completed: false}));
    }

    function update(uint index, string calldata _newText) external {
        Todo storage myTodo = todos[index];
        myTodo.text = _newText;
    }

    function get(uint index) external view returns (Todo memory) {
        Todo storage myTodo = todos[index];
        return myTodo;
    }

    function complet(uint index) external {
        Todo storage myTodo = todos[index];
        myTodo.completed = true;
    }
}
