// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
   //import "hardhat/console.sol";

contract ERC721 {
    string public name;
    string public symbol;

    mapping (address => uint) private  balance;

 constructor (string memory _name, string memory _symbol) {
     name = _name;
     symbol = _symbol;

      }
      

 function balanceOf(address _owner) public view returns (uint256) {
   require(_owner !=  address(0));
    return balance[_owner];
    } 
  
}
