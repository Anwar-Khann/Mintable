// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, Ownable {
    uint256 public limit;
    uint256 public fee = (10 * 10**18);
    address[] public minters;

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, uint256 tokenId) public payable {
        require(limit <= 50, "limit reached");
        require(msg.value == fee, "kindly send proper amounts");
        if (limit == 0) {
            //customize it for limit count
            address payable reciever = payable(getAdd());
            reciever.transfer(msg.value);
        } else if (limit >= 1 || limit <= 25) {}
        _safeMint(to, tokenId);
        minters.push(to);
        limit++;
    }

    function getAdd() public view returns (address) {
        return address(this);
    }

    function Balance() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}
