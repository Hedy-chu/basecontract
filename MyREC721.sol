// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import"@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import"@openzeppelin/contracts/access/Ownable.sol";

contract MyREC721 is Ownable,ERC721URIStorage{
    constructor () ERC721("MyErc721", "MY721")Ownable(msg.sender){
    }

    function mint(address to, uint256 tokenId) public{
        _mint(to, tokenId);
    }
}