// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Counter {
    uint public a;

    function add(uint x)public  returns (uint){
        return a = a+x;
    }
}