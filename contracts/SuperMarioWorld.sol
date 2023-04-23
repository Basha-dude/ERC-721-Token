// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
 import "./ERC721.sol";

contract SuperMarioWorld is ERC721   {
 
   string public name;
   string public symbol;

  uint256 public tokenCount;
  
  mapping (uint256 => string) _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

     function tokenURI(uint256 tokenId) public  returns (string memory) {
        require(_owners[tokenId] != address(0));
        return _tokenURIs[tokenId]; 
    }

    function mint(string memory _tokenURI)  public   {
        tokenCount += 1;
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;
        emit Transfer(address(0),msg.sender,tokenCount);

    }
}