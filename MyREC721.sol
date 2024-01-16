// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import"@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import"@openzeppelin/contracts/access/Ownable.sol";
import"@openzeppelin/contracts/utils/Counters.sol";

contract MyREC721 is Ownable,ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter public tokenIds;
    constructor () ERC721("MyErc721", "MY721")Ownable(msg.sender){
    }

    function mint(address to) public{
        _mint(to, tokenIds.current());
        tokenIds.increment();
    }
    
    function setTokenURI(uint256 tokenId, string memory _tokenURI) public  {
        _setTokenURI(tokenId, _tokenURI);
    }
}