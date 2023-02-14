// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, Ownable {
    uint256 public limit =0;
    uint256 public fee = 10 ether;
    address[] public minters;
    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, uint256 tokenId) public payable {
        require(limit <=49, "limit reached");
        require(msg.value == fee,"kindly send proper amounts");
        if(limit == 0){//customize it for limit count
            address payable reciever = payable(getAdd());
            reciever.transfer(msg.value);
            // limit++;
        }
        _safeMint(to, tokenId);
        minters.push(msg.sender);
        limit++;
    }

    function getAdd()public view returns(address){
        return address(this);
    }

    function Balance()public view returns(uint){
        return address(this).balance;
    }
}
