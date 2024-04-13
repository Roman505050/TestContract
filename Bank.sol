// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public ownerContract;

    constructor() {
        ownerContract = msg.sender;
    }

    modifier testOwner() {
        require(msg.sender == ownerContract, "Only the contract owner can call this function");
        _;
    }
}

contract Bank is Ownable {
    address public owner;
    mapping (address => uint) public  payments;
    event LogMessage(address sender);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        payments[msg.sender] += msg.value;
    }

    function withdraw() public {
        address payable _to = payable(msg.sender);
        uint amount = payments[msg.sender];
        if (amount != 0) {
            _to.transfer(amount);   
        } else {
            revert("Your balance is zero");
        }
        
    }

    function withdrawAll() public testOwner {
        address payable _to = payable (msg.sender);
        address _thisContract = address(this);
        _to.transfer(_thisContract.balance);
    }
}