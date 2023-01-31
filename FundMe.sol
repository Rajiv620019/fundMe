// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundME {
    using PriceConverter for uint;

    uint public minimumUSD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint) public addressToAmountFunded;

    // This function lets send fund 
    function fund() public payable {
        // Setting a minimum amount of ether to be sent
        require (msg.value.conversionRate() >= minimumUSD, "Didn't send enough ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    

    // This function lets owner of the contract to withdraw the funds
    // function withdrawFund() {}

}