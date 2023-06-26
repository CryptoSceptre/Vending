// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract VendingMachine{

    // state variables
    address public owner;
    mapping(address => uint) public waterBalances;

    // set the owner as th address that deployed the contract
    // set the initial vending machine balance to 100
    constructor(){
        owner = msg.sender;
        waterBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint) {
        return waterBalances[address(this)];
    }

    // Let the owner restock the vending machine
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock.");
        waterBalances[address(this)] += amount;
    }

    // Purchase donuts from the vending machine
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1.5 ether, "You must pay at least 1.5 ETH per bottle");
        require(waterBalances[address(this)] >= amount, "Not enough water bottles in stock to complete this purchase");
        waterBalances[address(this)] -= amount;
        waterBalances[msg.sender] += amount;
    }
}
