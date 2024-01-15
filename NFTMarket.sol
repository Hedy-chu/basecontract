// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import"@openzeppelin/contracts/access/Ownable.sol";
import"@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface IMyERC721 {
    function safeTransferFrom(address from, address to, uint256 tokenId) external ; 
    function approve(address to, uint256 tokenId) external;
}
contract NFTMarket is Ownable{
    IMyERC721 public nft;
    IERC20 public token;
    using SafeERC20 for IERC20;
    mapping (address => mapping (uint => uint)) listNft;
    mapping (uint => bool) onSale;
    error notOnSale();
    error hasBeBuyError();
    error priceError();

    constructor(address nftAddr,address tokenAddr) Ownable(msg.sender){
        nft = IMyERC721(nftAddr);
        token = IERC20(tokenAddr);
    }
    modifier checkPrice(uint price){
        require(price > 0, "price must bigger than zero");
        _;
    }

    function list(uint tokenId, uint price) public checkPrice(price){
        if (!onSale[tokenId]){
            revert notOnSale();
        }
        nft.approve(msg.sender,tokenId);
        nft.safeTransferFrom(msg.sender,address(this),tokenId);
        listNft[msg.sender][tokenId] = price;
        onSale[tokenId] = true;
    }

    function buyNft(uint tokenId, uint amount) public {
        if (!onSale[tokenId]){
            revert notOnSale();
        }
        if (amount < listNft[msg.sender][tokenId]){
            revert priceError();
        }
        token.safeTransferFrom(msg.sender,address(this),amount);
        nft.safeTransferFrom(address(this),msg.sender,tokenId);
        listNft[msg.sender][tokenId] = 0;
        onSale[tokenId] = false;
    }
}