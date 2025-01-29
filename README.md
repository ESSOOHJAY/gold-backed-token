# Gold Backed Token (GBT) Smart Contract

A Stacks blockchain implementation of a gold-backed token using Clarity smart contracts. This token contract enables secure minting, transfer, and redemption of gold-backed tokens.

## Features

- 🏦 Controlled token minting by contract owner
- 💸 Secure token transfers between accounts
- 🔄 Token redemption mechanism
- 📊 Balance and supply tracking
- 🔒 Built-in security checks

## Contract Functions

### Public Functions

- `mint(recipient, amount)`: Mint new tokens to a recipient (owner only)
- `transfer(recipient, amount)`: Transfer tokens between accounts
- `redeem(amount)`: Burn tokens to redeem underlying asset
- `get-balance(user)`: Query account balance
- `get-total-supply()`: Get total token supply

### Error Codes

- `ERR_NOT_OWNER (u100)`: Unauthorized operation
- `ERR_INSUFFICIENT_BALANCE (u101)`: Insufficient funds
- `ERR_INVALID_AMOUNT (u102)`: Invalid amount specified
- `ERR_INVALID_RECIPIENT (u103)`: Invalid recipient address

## Installation

1. Install [Clarinet](https://github.com/hirosystems/clarinet)
2. Clone this repository
```bash
git clone https://github.com/yourusername/gbt-contract
cd gbt-contract
