# 🧭 OCOS-Binance Smart Contract Flow Architecture

## Overview

This document provides a detailed overview of the smart contract flow architecture for the **OCOS-Binance Bridge Protocol**, enabling secure, transparent, and auditable liquidity synchronization between the decentralized OCOS Token (BEP20) ecosystem and Binance (CEX).

The protocol consists of multiple interoperable smart contracts that govern token flow, reserve validation, and price feed integration through Chainlink oracles.

---

## 📐 Contract Interaction Layers

### 1. **User Layer**
- Wallets interacting with OCOS Token via DApps or exchanges.
- Interacts with:
  - `OCOSBridge` for deposit and withdrawal.
  - `OCOSToken` directly (transfers, approvals).

### 2. **Core Contract Layer**
| Contract                     | Purpose                                                 |
|-----------------------------|---------------------------------------------------------|
| `OCOSBridge.sol`            | Core bridge that handles user deposits/withdrawals and connects with Binance |
| `BinanceLiquidityManager.sol` | Ensures liquidity matching and reserves are balanced  |
| `OCOSToken.sol`             | Standard BEP20 token contract integrated into the protocol |

### 3. **Reserve and Oracle Layer**
| Contract                     | Purpose                                                 |
|-----------------------------|---------------------------------------------------------|
| `OCOSReserveVault.sol`      | Stores actual reserves backing the OCOS token           |
| `OCOSReserveMonitor.sol`    | Tracks reserves and emits `ProofOfReserve` events       |
| `OCOSChainlinkPriceFeed.sol`| Provides OCOS/BNB and OCOS/USDT price updates via Chainlink |

---

## 🔄 Token Flow Process

### 📥 Deposit (Binance → OCOS Wallet)
1. Binance initiates off-chain deposit to bridge wallet.
2. Authorized Binance wallet calls `depositFromBinance(address, amount)` on `OCOSBridge`.
3. Contract mints or releases OCOS tokens to user's wallet.
4. Event `DepositReceived` is emitted.
5. `OCOSReserveVault` balance is updated accordingly.

### 📤 Withdrawal (OCOS Wallet → Binance)
1. User initiates withdrawal via DApp or directly.
2. `withdrawToBinance(address, amount)` is called.
3. Tokens are locked or burned from user’s balance.
4. Event `WithdrawalRequested` is emitted.
5. Binance confirms receipt off-chain and settles fiat or alternative asset.

---

## 🧠 Oracle Synchronization Logic

- Chainlink fetches price feeds for OCOS/BNB and OCOS/USDT every 5 minutes.
- `OCOSChainlinkPriceFeed` updates are consumed by `BinanceLiquidityManager`.
- `OCOSReserveMonitor` tracks reserve vault balance and emits snapshots hourly.
- Liquidity imbalance or price anomalies trigger on-chain alerts for governance review.

---

## 🔐 Security Enforcement

| Mechanism                   | Description                                         |
|----------------------------|-----------------------------------------------------|
| Role-based Access Control  | Only Binance-signed wallets can call bridge methods |
| Multi-signature Governance | ReserveVault and LiquidityManager are controlled via multisig |
| TimeLocks                  | Sensitive updates are protected by time delays     |
| Audits                     | Smart contracts undergo formal verification by CertiK or similar |

---

## 🌐 Event Logging (Audit Trail)

| Event Name              | Emitted By             | Purpose                                     |
|------------------------|------------------------|---------------------------------------------|
| `DepositReceived`      | `OCOSBridge`           | Logs incoming Binance-side token issuance   |
| `WithdrawalRequested`  | `OCOSBridge`           | Logs outgoing token burn or transfer        |
| `ProofOfReserve`       | `OCOSReserveMonitor`   | Publishes periodic reserve snapshots        |
| `PriceUpdated`         | `OCOSChainlinkFeed`    | Tracks updated prices for liquidity logic   |

---

## 🗺 Flow Diagram

```mermaid
graph TD;
    Binance[CEX Binance Wallet] -->|depositFromBinance| OCOSBridge
    OCOSBridge --> OCOSToken
    OCOSToken --> OCOSWallet[User Wallet]
    OCOSToken --> LiquidityManager
    LiquidityManager --> OCOSVault
    OCOSVault -->|report| ReserveMonitor
    Chainlink -->|updatePrice| PriceFeed
    PriceFeed --> LiquidityManager
