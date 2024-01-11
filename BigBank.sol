// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Bank.sol";

contract BigBank is Bank{

    constructor(address _owner) {
        owner = _owner;
    }
    
    modifier checkAmount(uint amount){
        require(amount > 1000000000000000,"Deposits should be greater than 0.001ether");
        _;
    }
    function deposite()public payable override checkAmount(msg.value){
        super.deposite();
    }

}