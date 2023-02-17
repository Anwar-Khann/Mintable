// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNft is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 50;
    uint256 public currentSupply;
    uint256 public fee = 10 * 10**18;
    address[] public minters;
    IERC20 public anteMatter;

    constructor(address _contract) ERC721("MyToken", "MTK") {
        anteMatter = IERC20(_contract);
    }

    function safeMint(uint256 tokenId) public {
        require(currentSupply < MAX_SUPPLY);
        require(anteMatter.balanceOf(msg.sender) >= fee, "insufficient usdt");
        if (currentSupply == 0) {
            anteMatter.transferFrom(msg.sender, address(this), fee);
            emit Approval(msg.sender, address(this), fee);
        } else if (currentSupply == 1 || currentSupply <= 25) {
            uint256 contractCut = (fee * 90) / 100;
            uint256 ownersCut = fee - contractCut;
            anteMatter.transferFrom(msg.sender, address(this), contractCut);
            uint256 length = minters.length;
            for (uint256 i = 0; i < length; i++) {
                uint256 toOwners = ownersCut / length;
                anteMatter.transfer(minters[i], toOwners);
            }
        }  else if (currentSupply > 25 && currentSupply <= MAX_SUPPLY) {
            uint256 contractCut = (fee * 80) / 100;
            uint256 ownersCut = fee - contractCut;
            anteMatter.transferFrom(msg.sender, address(this), contractCut);
            uint256 length = minters.length;
            for (uint256 i = 0; i < length; i++) {
                uint256 toOwners = ownersCut / length;
                anteMatter.transfer(minters[i], toOwners);
            }
        }
        _safeMint(msg.sender, tokenId);
        minters.push(msg.sender);
        currentSupply++;
        fee += (10 * 10**18);
    }

    function getAdd() public view returns (address) {
        return address(this);
    }

    function withdrawTokens() public onlyOwner {
    uint256 balance = anteMatter.balanceOf(address(this));
    anteMatter.transfer(msg.sender, balance);
}
}
