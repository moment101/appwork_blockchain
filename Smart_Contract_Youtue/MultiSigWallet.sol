// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    address[] public owners;
    mapping(address => bool) isOwner;

    uint public required;
    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) approved;

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier exist(uint _txId) {
        require(_txId < transactions.length, "tx didn't exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        Transaction storage transaction = transactions[_txId];
        require(!transaction.executed, "already executed");
        _;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "Owners number is zero");
        require(
            _owners.length >= _required && _required > 0,
            "required number isn't valid"
        );
        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];
            require(!isOwner[owner], "is owner already.");
            require(owner != address(0), "address invalid");
            owners.push(owner);
            isOwner[owner] = true;
        }
        required = _required;
    }

    function submit(
        address _to,
        uint _value,
        bytes calldata _data
    ) external onlyOwner {
        require(_to != address(0), "_to address is zero");
        require(
            _value <= address(this).balance,
            "value is greater than balance"
        );
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );
        emit Submit(transactions.length - 1);
    }

    function approve(
        uint _txId
    ) external onlyOwner exist(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovalCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    function execute(
        uint _txId
    ) external onlyOwner exist(_txId) notExecuted(_txId) {
        require(
            _getApprovalCount(_txId) >= required,
            "Approval numbers is not enough."
        );
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "execute failed");
        emit Execute(_txId);
    }

    function revoke(
        uint _txId
    ) external onlyOwner exist(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "not approved yet");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
