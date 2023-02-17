//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TetherUsd is ERC20, Ownable {
    constructor() ERC20("TetherUsd", "USDT") {}

    function mint(uint256 amount) public {
        _mint(msg.sender, amount *10**18);
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount*10**decimals());
        return true;
    }
}