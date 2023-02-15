// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC721, Ownable {
    uint256 public limit;
    uint256 public fee = (10 * 10**18);
    address payable[] public minters;

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, uint256 tokenId) public payable {
        require(limit <= 50, "limit reached");
        require(msg.value == fee, "Haha you Broke");
        if (limit == 0) {
            //customize it for limit count
            address payable reciever = payable(getAdd());
            reciever.transfer(msg.value);
        } else if (limit == 1 || limit <= 25) {
            uint256 count = (fee * 90) / 100;
            // uint local = count - fee;
            address payable reciever = payable(getAdd());
            reciever.transfer(count);
            uint256 local = fee - count;
            uint256 length = minters.length;

            for (uint256 i = 0; i < length; i++) {
                uint256 send = local / length;
                minters[i].transfer(send);
            }
        } else if (limit > 25) {
            uint256 count = (fee * 80) / 100;
            address payable reciever = payable(getAdd());
            reciever.transfer(count);
            uint256 local = fee - count;

            uint256 length = minters.length;
            for (uint256 i = 0; i < length; i++) {
                uint256 toSend = local / length;
                minters[i].transfer(toSend);
            }
        }
        _safeMint(to, tokenId);
        minters.push(payable(to));
        limit++;
        fee += (10 * 10**18);
    }

    function getAdd() public view returns (address) {
        return address(this);
    }

    function Balance() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}
