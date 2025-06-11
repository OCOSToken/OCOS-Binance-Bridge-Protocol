# 🧠 OCOS Oracle Architecture

## 📌 Overview

This document provides a detailed breakdown of the oracle architecture used in the **OCOS-Binance-Bridge-Pro** protocol. It describes how real-time asset reserves, price feeds, and liquidity integrity are maintained through smart contract-based oracles — ensuring full transparency and compliance between the OCOS decentralized ecosystem and Binance CEX integrations.

---

## 🧭 Oracle Objectives

- 🎯 **Track and verify OCOS reserve balances** backing Binance liquidity.
- 🎯 **Emit blockchain-based proof of reserves** at configurable intervals.
- 🎯 **Validate OCOS/BNB and OCOS/USDT price feeds** using Chainlink.
- 🎯 **Enable off-chain systems (e.g., Binance API)** to monitor smart contract state changes securely.
- 🎯 **Facilitate automatic syncs between liquidity pools and reserve vaults.**

---

## 🧱 Core Oracle Components

### 1. `OCOSReserveMonitor.sol`
A smart contract oracle that:
- Tracks OCOS, BNB, and stablecoin balances in the designated reserve vault.
- Emits `event ReserveProofGenerated(...)` to provide real-time on-chain reserve proofs.
- Stores all snapshots with timestamps for historical analysis and auditability.
- Allows only the contract `admin` to generate snapshots, preventing external tampering.

### 2. `OCOSChainlinkPriceFeed.sol`
An oracle connector that:
- Retrieves real-time OCOS/BNB and OCOS/USDT prices using Chainlink decentralized data feeds.
- Can be called by the Liquidity Manager contract to:
  - Enforce fair pricing.
  - Prevent manipulation.
  - Ensure liquidity ratios remain within acceptable bounds.

### 3. `LiquidityOracleSync.js` (scripts layer)
A JavaScript (or TypeScript) script that:
- Periodically pings smart contracts to fetch latest reserve and price states.
- Optionally posts updates to off-chain dashboards or Binance backend APIs.
- Logs and exports structured snapshots (JSON/CSV) for internal or third-party audits.

---

## 🔐 Security & Reliability

| Mechanism             | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Access Control        | `onlyAdmin` and/or `onlyOwner` modifiers restrict critical oracle updates. |
| Time-Locking          | Snapshot intervals are rate-limited to avoid spam or malicious spam attacks. |
| Chainlink Integration | Price feeds are decentralized and verifiable using Chainlink Proof-of-Reserve. |
| Snapshot History      | All reserve states are permanently stored and retrievable on-chain.         |
| Emitted Events        | Every update emits detailed logs accessible to off-chain indexers.          |

---

## 📊 Example: Reserve Snapshot Event

```solidity
event ReserveProofGenerated(
    uint256 timestamp,
    uint256 stableBalance,
    uint256 bnbBalance,
    uint256 ocosBalance
);
