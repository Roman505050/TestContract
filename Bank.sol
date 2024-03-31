// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address public owner;
    mapping (address => uint) public  payments;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        payments[msg.sender] += msg.value;
    }

    function withdrawAll() public {
        address payable _to = payable(msg.sender);
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
    }
}