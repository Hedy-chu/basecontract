// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IBank {
    function withdraw() payable  external ;
}

contract Ownable {
    function withdraw(address bank) public payable {
        IBank(bank).withdraw();
        // address payable ownable = payable (msg.sender);
        // ownable.transfer(msg.value);
    }

    // 只要收钱就一定要有receive函数
    receive() external payable { }
    
}