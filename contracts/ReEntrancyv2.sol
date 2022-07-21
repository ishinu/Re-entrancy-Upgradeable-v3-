// 1. Contract which is vulnerable to Re-Entrancy attack.
// 2. EtherStore : An imaginary virtual bank where people can deposit and withdraw digital currency.
// 3. With the help of 'Laika', you can send function call requests and get response to check this implementation.
// 4. Make sure 'Ganache' which is our local machine blockchain is running before you deploy the migration.
// 5. For any query regarding this contract implementation, feel free to contact tysmgroups@gmail.com
// 6. Depositors can check and withdraw their balance.

//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract ReEntrancyv2{
    mapping(address=>uint256) public balances;
    bool internal locked;
    uint256 internal bal;
    
    modifier noReentrancy(){
        require(!locked,"No Re-entrancy");
        locked=true;
        _;
        locked=false;
    }
    
    function deposit() public payable{
        balances[msg.sender] +=  msg.value;
    }

    // 1. First method to withdraw

    function withdraw() public payable noReentrancy{
        bal = balances[msg.sender];
        require(bal>0);
        (bool sent,) = msg.sender.call{value:bal}("");
        require(sent,'Can"t Withdraw Ether.');
        balances[msg.sender] = 0;
    }
    function getBalances() public view returns(uint256){
        return address(this).balance;
    }
    function checkBalance() public view returns(uint256){
        return balances[msg.sender];
    }
    // 2. Second method to withdraw if the one above breaks. ( doesn't work ;) )

    function withdrawBalance() public payable returns(bool success){
        bal = balances[msg.sender];
        payable(msg.sender).transfer(bal);
        balances[msg.sender] = 0;
        return true;
    } 
}