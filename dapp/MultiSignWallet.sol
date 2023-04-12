// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiSignWallet {
    // events
    event deposit(address indexed sender, uint amount);
    event submit(uint indexed transactionId);
    event approve(address indexed owner, uint indexed transactionId);
    event revoke(address indexed owner, uint indexed transactionId);
    event execute(uint indexed transactionId);

    // modifier
    modifier onlyOwner() {
        require(isOwner[msg.sender], "You are not one of owners");
        _;
    }

    modifier transactionExists(uint transactionId) {
        require(
            transactionId < transactions.length,
            "Transcation id not exists"
        );
        _;
    }

    modifier transactionNotApproved(uint transactionId) {
        require(
            !approved[transactionId][msg.sender],
            "Transaction has been approved"
        );
        _;
    }

    modifier transactionNotExecuted(uint transactionId) {
        require(
            !transactions[transactionId].executed,
            "Transaction has been executed"
        );
        _;
    }

    // struct
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    // initilize in constructor
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public required; // needs greater than this number to complete a transaction
    //
    address sender;
    Transaction[] public transactions;
    // transactionId => (address => bool)
    mapping(uint => mapping(address => bool)) public approved;

    // constructor
    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "Owners length must be greater than 0");
        require(
            _required > 0 && _owners.length >= _required,
            "Invalid required number"
        );

        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "0 is invalid address");
            require(!isOwner[owner], "Owner address already exists");

            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }

    // lower level transfer
    receive() external payable {
        emit deposit(msg.sender, msg.value);
    }

    // add a transaction into array
    function submitFunc(
        address _to,
        uint _value,
        bytes calldata _data
    ) public payable onlyOwner {
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );

        emit submit(transactions.length - 1);
    }

    // approve transaction
    function approveFunc(
        uint _transactionId
    )
        public
        onlyOwner
        transactionExists(_transactionId)
        transactionNotApproved(_transactionId)
        transactionNotExecuted(_transactionId)
    {
        approved[_transactionId][msg.sender] = true;

        emit approve(msg.sender, _transactionId);
    }

    // revoke approved transaction (not executed)
    function revokeFunc(
        uint _transactionId
    )
        public
        onlyOwner
        transactionExists(_transactionId)
        transactionNotExecuted(_transactionId)
    {
        require(approved[_transactionId][msg.sender], "Not approved");
        approved[_transactionId][msg.sender] = false;

        emit revoke(msg.sender, _transactionId);
    }

    // execute: sending money from current contract balance
    // initial balance is 0, we can use receive() to deposit
    function executeFunc(
        uint _transactionId
    )
        public
        onlyOwner
        transactionExists(_transactionId)
        transactionNotExecuted(_transactionId)
    {
        require(
            _getNumberOfConfirm(_transactionId) > required,
            "Not enough people approve with this transaction"
        );

        // storage: we need to update block chain data
        Transaction storage transaction = transactions[_transactionId];
        transaction.executed = true;

        // CALL: send money
        (bool callSuccess, ) = payable(transaction.to).call{
            value: transaction.value
        }(transaction.data);
        require(callSuccess, "CALL: send money failed");

        emit execute(_transactionId);
    }

    function _getNumberOfConfirm(
        uint _transactionId
    ) public view returns (uint) {
        uint count = 0;
        for (uint i = 0; i < owners.length; i++) {
            if (approved[_transactionId][owners[i]]) {
                count++;
            }
        }
        return count;
    }
}
