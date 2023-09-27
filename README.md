# MyToken Smart Contract Documentation

## Overview

The MyToken smart contract is an ERC-721 compliant token that allows for the creation and management of unique tokens. It includes features for minting tokens, setting token limits, and handling fees. This contract is designed to be owned and operated by an address that has been granted ownership privileges.

## Contract Details

- **Contract Name:** MyToken
- **SPDX-License-Identifier:** MIT
- **Solidity Version:** 0.8.9
- **Inherits From:** ERC721, Ownable

## State Variables

- `limit` (public `uint256`): The limit on the total number of tokens that can be minted.
- `fee` (public `uint256`): The fee required to mint a token, denominated in wei.
- `minters` (public `address payable[]`): An array of addresses that have minted tokens.

## Constructor

### `constructor()`

- **Description:** Initializes the contract with the name "MyToken" and the symbol "MTK".

## Functions

### `safeMint(address to, uint256 tokenId)`

- **Description:** Mints a new token and assigns it to the specified address.
- **Parameters:**
  - `to` (address): The address to which the new token will be assigned.
  - `tokenId` (uint256): The unique identifier for the new token.
- **Modifiers:**
  - Requires that the token limit has not been reached.
  - Requires that the sender has sent the correct minting fee.
- **Effects:**
  - Transfers the minting fee to the contract owner's address.
  - Distributes a portion of the minting fee to existing minters.
  - Mints a new token and assigns it to the specified address.
  - Adds the address to the list of minters.
  - Increments the token limit.
  - Increases the minting fee for subsequent minting.

### `getAdd()`

- **Description:** Retrieves the address of the contract.
- **Returns:** The address of the contract.

### `Balance()`

- **Description:** Retrieves the current balance of the contract in wei.
- **Returns:** The contract's balance.

### `receive()`

- **Description:** Allows the contract to receive ether. This function is triggered when ether is sent to the contract.

## Usage

The MyToken contract can be used to create and manage unique tokens in an Ethereum application. It implements ERC-721 standards for non-fungible tokens (NFTs) and allows for the minting of new tokens by users who pay the required minting fee.


For questions or issues related to this contract, please contact.
