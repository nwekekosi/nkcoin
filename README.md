# NK Coin (NKCOIN)

A SIP-010 compliant fungible token smart contract built on the Stacks blockchain using Clarity.

## Overview

NK Coin is a fungible token that implements the SIP-010 standard, providing a secure and standardized way to create and manage tokens on the Stacks blockchain. The contract includes features for token transfers, minting, burning, and metadata management.

## Features

- **SIP-010 Compliant**: Fully implements the SIP-010 fungible token standard
- **Token Transfers**: Send tokens between accounts with optional memo
- **Minting**: Contract owner can mint new tokens
- **Burning**: Token holders can burn their own tokens
- **Balance Queries**: Check balance of any account
- **Total Supply Tracking**: Monitor the total circulating supply
- **Metadata Support**: Token name, symbol, decimals, and URI
- **Access Control**: Owner-only functions for sensitive operations

## Token Details

- **Name**: NK Coin
- **Symbol**: NK
- **Decimals**: 6
- **Initial Supply**: 1,000,000 NK (1,000,000,000,000 micro-units)

## Contract Functions

### SIP-010 Standard Functions

#### `transfer`
```clarity
(transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
```
Transfer tokens from sender to recipient. Only the sender can initiate their own transfer.

#### `get-name`
```clarity
(get-name)
```
Returns the token name: "NK Coin"

#### `get-symbol`
```clarity
(get-symbol)
```
Returns the token symbol: "NK"

#### `get-decimals`
```clarity
(get-decimals)
```
Returns the number of decimals: 6

#### `get-balance`
```clarity
(get-balance (account principal))
```
Returns the token balance of the specified account.

#### `get-total-supply`
```clarity
(get-total-supply)
```
Returns the total supply of tokens in circulation.

#### `get-token-uri`
```clarity
(get-token-uri)
```
Returns the URI for token metadata (if set).

### Additional Functions

#### `mint`
```clarity
(mint (amount uint) (recipient principal))
```
Mint new tokens to a recipient address. **Owner only.**

#### `burn`
```clarity
(burn (amount uint) (owner principal))
```
Burn tokens from the caller's balance.

#### `set-token-uri`
```clarity
(set-token-uri (uri (string-utf8 256)))
```
Set the metadata URI for the token. **Owner only.**

## Error Codes

- `u100`: `err-owner-only` - Function can only be called by contract owner
- `u101`: `err-not-token-owner` - Caller is not the token owner
- `u102`: `err-insufficient-balance` - Insufficient balance for operation
- `u103`: `err-invalid-amount` - Invalid amount (must be greater than 0)

## Development

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity runtime packaged as a CLI
- Node.js (for testing)

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/nkcoin.git
cd nkcoin
```

2. Install dependencies:
```bash
npm install
```

### Testing

Run the contract checks:
```bash
clarinet check
```

Run the test suite:
```bash
clarinet test
```

### Deployment

1. Configure your deployment settings in `settings/Devnet.toml`, `settings/Testnet.toml`, or `settings/Mainnet.toml`

2. Deploy to testnet:
```bash
clarinet deployments generate --testnet
clarinet deployments apply -p <deployment-plan>
```

## Project Structure

```
nkcoin/
├── contracts/
│   └── nkcoin.clar          # Main token contract
├── tests/
│   └── nkcoin.test.ts       # Contract tests
├── settings/
│   ├── Devnet.toml          # Development network settings
│   ├── Testnet.toml         # Testnet settings
│   └── Mainnet.toml         # Mainnet settings
├── Clarinet.toml            # Clarinet configuration
├── package.json             # Node.js dependencies
└── README.md                # This file
```

## Security Considerations

- The contract owner has special privileges (minting, setting URI)
- Users can only transfer their own tokens
- All token amounts must be greater than 0
- Burns are irreversible
- Initial supply is minted to the contract deployer

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Resources

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/overview)
- [SIP-010 Fungible Token Standard](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md)
- [Clarinet Documentation](https://docs.hiro.so/clarinet)

## Contact

For questions or support, please open an issue on GitHub.
