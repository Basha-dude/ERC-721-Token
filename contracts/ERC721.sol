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
    mapping (uint256 => address) internal  tokenIdApproval;


    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
     event Approval(
        address indexed _owner,
        address indexed _approved,
       uint256 indexed _tokenId
       );
     event Transfer(address indexed _from, address indexed  _to, uint256 indexed _tokenId); 

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
    function approve(address _approved, uint256 _tokenId) public {
           address owner = ownerOf(_tokenId);
           require(msg.sender == owner || isApprovedForAll(owner,msg.sender));
           tokenIdApproval[_tokenId] = _approved;
                emit Approval(owner,_approved,_tokenId);
    }
    
    function getApproved (uint256 _tokenId) public view returns (address) {
        require(_owners[_tokenId] != address(0));
        return tokenIdApproval[_tokenId];
    }     

    function transferFrom(address _from, address _to, uint256 _tokenId) public  {
          address owner  =  _owners[_tokenId];
          require(msg.sender == owner || getApproved(_tokenId) == msg.sender|| isApprovedForAll(owner,msg.sender));
          require(owner == _from);
        require(_owners[_tokenId] != address(0));
         _balance[_from]  -= 1;
         _balance[_to]  += 1;
         _owners[_tokenId] = _to; 

         approve(address(0), _tokenId);
         emit Transfer( _from, _to, _tokenId);
    }

     function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public {
        transferFrom(_from, _to, _tokenId);
        require(_checkOnERC721Received());

    }
      function _checkOnERC721Received () private pure returns (bool) {
            return true;
      }   

      function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
             safeTransferFrom(_from, _to, _tokenId,"");
         }
      function supportsInterface(bytes4 interfaceID) external view returns (bool) {
            return interfaceID == 0x80ac58cd;
           }
  }

