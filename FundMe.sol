// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundME {

    // This function lets send fund 
    function fund() public payable {
        // Setting a minimum amount of ether to be sent
        require(msg.value > 1e18, "Didn't send enough ether");
    }

    // This function lets owner of the contract to withdraw the funds
    // function withdrawFund() {}

}