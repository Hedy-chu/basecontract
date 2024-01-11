// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IBank {
    function withdraw() external ;
}

contract Ownable {
    function withdraw(address bank) public {
        IBank(bank).withdraw();
        // address payable ownable = payable (msg.sender);
        // ownable.transfer(msg.value);
    }
    
}