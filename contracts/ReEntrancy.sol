// 1. Contract which is vulnerable to Re-Entrancy attack.
// 2. EtherStore : An imaginary virtual bank where people can deposit and withdraw digital currency.
// 3. With the help of 'Laika', you can send function call requests and get response to check this implementation.
// 4. Make sure 'Ganache' which is our local machine blockchain is running before you deploy the migration.
// 5. For any query regarding this contract implementation, feel free to contact tysmgroups@gmail.com

//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ReEntrancy{
    mapping(address=>uint256) public balances;
    
    function deposit() public payable{
        balances[msg.sender] +=  msg.value;
    }
    function withdraw() public{
        uint256 bal = balances[msg.sender];
        require(bal>0);
        (bool sent,) = msg.sender.call{value:bal}("");
        require(sent,'Can"t Withdraw Ether.');
        balances[msg.sender] = 0;
    }
    function getBalances() public view returns(uint256){
        return address(this).balance;
    }
}