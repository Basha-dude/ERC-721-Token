// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract ERC721 {
    string public name;
    string public symbol;

    mapping (address => uint) private  _balance;
    mapping (uint => address) public  _owners;
    mapping (address => mapping (address => bool)) internal  operatorsApproval;

    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    constructor (string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner !=  address(0));
        return _balance[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner  =  _owners[_tokenId];
        require (owner != address(0));
        return owner;
    }

    function setApprovalForAll(address _operator, bool _approved) public {
        operatorsApproval[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender,_operator,_approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return  operatorsApproval[_owner][_operator];
    }
}
