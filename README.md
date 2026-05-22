# BINHA Token (`BIN`)

An educational, standard-compliant ERC-20 token built from scratch in Solidity using Hardhat. This repository tracks the core permission mappings (`approve` and `transferFrom`), native math mechanics under the EVM, and strict deployment testing.

## Token Specifications

- **Name:** BINHA
- **Symbol:** BIN
- **Decimals:** 18 (Standard ETH symmetry)
- **Total Supply:** 1,000,000,000 BIN (1 Billion full tokens)
- **License:** GPL-3.0

## Features Implemented

*   **Fixed Tokenomics Configuration:** Decimals are hardcoded as a `constant` to maximize runtime gas-savings, with the initial 1-billion token supply minted safely to the deployer at genesis.
*   **CEI Pattern Adherence:** The `transferFrom` function explicitly follows the Checks-Effects-Interactions architecture to eliminate reentrancy vulnerabilities.
*   **Custom Gas-Optimized Errors:** Implements efficient Solidity custom errors (`NotEnoughFunds`, `NoAllowanceEnough`) over traditional string-revert gas hogs.

---

## Architecture Breakdown

Instead of transmitting physical assets over the wire, this token operates as a lightweight ledger leveraging nested cryptographic mappings:

*   `balances`: Tracks the integer token ownership balance for individual wallet addresses.
*   `allowances`: Manages third-party budgets, enabling secure interaction with Decentralized Exchanges (DEXs) like Uniswap without exposing whole wallet private keys.

---

## Getting Started

### 1. Prerequisites
Ensure you have [Node.js](https://nodejs.org/) installed, along with your preferred package manager (npm, yarn, or pnpm).

### 2. Installation
Clone your project repository and install the development environment stack:
```bash
npm install