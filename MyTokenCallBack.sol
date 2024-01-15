// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MyToken.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import"@openzeppelin/contracts/token/ERC20/ERC20.sol";
import"@openzeppelin/contracts/access/Ownable.sol";

interface ITokenBankV1 {
    function tokensReceived(address user, uint amount) external  returns (bool);
}

contract MyTokenCallBack is ERC20,Ownable{
    error callBackError();
    error codeError();

    constructor(string memory name, string memory symbol) ERC20(name, symbol) Ownable(msg.sender){
    }

    function transfer(address to, uint256 amount) public override  returns (bool)  {
        uint balance = balanceOf(msg.sender);
        require(balance >= amount, "balance not enough");
        _update(msg.sender, to, amount);
        
        // Check if the recipient is a contract
        if (to.code.length > 0){
            bool callBack = ITokenBankV1(to).tokensReceived(msg.sender, amount);
            if (callBack){
                return true;
            }else{
                revert callBackError();
            }
        }
        return true;
       
    }

    function mint(address to, uint256 value) public onlyOwner{
        _mint(to, value);
    }
}