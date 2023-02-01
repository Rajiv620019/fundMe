// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundME {
    using PriceConverter for uint;

    uint public constant minimumUSD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint) public addressToAmountFunded;

    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    // This function lets send funds 
    function fund() public payable {
        // Setting a minimum amount of ether to be sent
        require (msg.value.conversionRate() >= minimumUSD, "Didn't send enough ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // This function lets owner of the contract to withdraw the funds
    function withdrawFund() public onlyOwner {
        for(uint funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // Resetting the array
        funders = new address[] (0);

        // Withdrawing funds from the contracts
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner");
        _;
    }
}