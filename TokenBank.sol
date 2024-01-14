// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import"./MyToken.sol";

interface IMyToken {
    function approve(address to, uint amount) external returns (bool) ;
    function transferFrom(address from,address to,uint amount) external returns (bool);
    function transfer(address to, uint amount) external;
    function balanceOf(address addr) external view returns (uint);
}

contract TokenBank {
    address public tokenAddr;
    address public owner;
    mapping (address => uint) public depositAmount;
    error withdrowError();

    constructor(address addr) {
        tokenAddr = addr;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "only owner can do it");
        _;
    }

    function deposit(uint amount) public {
        uint senderBalance = IMyToken(tokenAddr).balanceOf((msg.sender));
        require(senderBalance > amount,"deposit fail");
        bool result = IMyToken(tokenAddr).transferFrom(msg.sender,address(this),amount);
        if (result){
            depositAmount[msg.sender] += amount;
        }
        
    }

    function withdrow() public onlyOwner {
        require(IMyToken(tokenAddr).balanceOf((address(this))) > 0,"no balance");
        IMyToken(tokenAddr).transfer(msg.sender,IMyToken(tokenAddr).balanceOf((address(this))));
    }

}