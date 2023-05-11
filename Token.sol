// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IERC20.sol";

/**
 *  Exercise: [1] Write a smart contract that implements the ERC-20 standard.
 *            [2] Create a file `src/test/Token.t.sol` and write test cases for your ERC-20 smart contract.
 *                Look at the test case for exercise-1 as reference.
 *                
**/

contract Token is IERC20 {
    event Bought(uint256 amount);
    event Sold(uint256 amount);
    IERC20 public token;
    constructor() {
	        token = new ExchangeERC20Program();
	    }	
	    function buy() payable public {
	        uint256 selection = msg.value;
	        uint256 balanceofUser = token.balanceOf(address(this));
	        require(selection > 0, "You need to send some ether");
	        require(selection <= balanceofUser, "Not enough tokens in the reserve");
	        token.transfer(msg.sender, selection);
	        emit Bought(selection);
	    }
	
	    function sell(uint256 etherQuantity) public {
	        require(etherQuantity > 0, "You need to sell at least some tokens");
	        uint256 allowance = token.allowance(msg.sender, address(this));
	        require(allowance >= etherQuantity, "Check the token allowance");
	        token.transferFrom(msg.sender, etherQuantity(this), etherQuantity);
	        payable(msg.sender).transfer(etherQuantity);
	        emit Sold(etherQuantity);
	    }
}
