// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Bank {
    mapping (address => uint) public depositeAccount;
    address[3] public topAccount;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 接收eth
    receive() external payable {

    } 

    /**
      存款合约
    **/
    function deposite () public payable {
        require(msg.value > 0,"The deposit should be greater than zero");
        depositeAccount[msg.sender] += msg.value;
        for (uint i = 0; i < 3; i++) {
            address account = topAccount[i];
            uint amount = depositeAccount[account];
            if(msg.value> amount){
                topAccount[i] = msg.sender;
                if (i == 2 ){
                    break;
                }else if(i == 0){
                    topAccount[2] = topAccount[1];
                    topAccount[1] = account;
                }else {
                    topAccount[2] = account;
                }
                break;
            }
        }
    }

    function withdraw() public {
        require(owner == msg.sender,"only owner can withdraw");
        address payable sender = payable (msg.sender);
        sender.transfer(address(this).balance);
    }

    function balance() public view returns (uint){
       return address(this).balance;
    }
    
}

