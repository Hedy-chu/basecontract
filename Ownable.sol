// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IBank {
    function withdraw() external ;
}


contract Ownable {
    address owner;
     constructor(address _owner) {
        owner = _owner;
    }
    modifier ownerCheck(){
        require(owner == msg.sender, "must be owner");
        _;
    }
    function withdraw(address bank) public  ownerCheck{
        IBank(bank).withdraw();
        // 把钱转给用户
        address payable sender = payable (msg.sender);
        (bool success,) = sender.call{value:address(this).balance}("");
        if(!success){
            revert();
        }
    }

    // 只要收钱就一定要有receive函数
    receive() external payable { }
    
}