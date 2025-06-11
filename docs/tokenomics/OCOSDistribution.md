# 📊 OCOS Token Distribution Model

**File location:** `docs/tokenomics/OCOSDistribution.md`  
**Project:** OCOS Token (BEP20)  
**Network:** Binance Smart Chain (BSC)  
**Contract Address:** `0xa249ba073c01ceb65eafae7625d8f503c1f61c84`  
**Audit:** Verified by CertiK – see `docs/audit/certik-final-audit.md`

---

## 🧩 Overview

This document provides an official, transparent, and finalized breakdown of the OCOS Token distribution model. The allocation was designed with long-term sustainability, market health, liquidity protection, and community incentives in mind. All allocations are secured via multi-signature wallets and vesting smart contracts.

---

## 📦 Token Supply Summary

| Parameter               | Value                |
|-------------------------|----------------------|
| **Total Supply**        | 1,000,000,000 OCOS   |
| **Token Standard**      | BEP20 (Binance Smart Chain) |
| **Decimals**            | 18                   |
| **Minting**             | Disabled (Fixed supply) |
| **Burn Mechanism**      | Enabled (manual/auto) |
| **Vesting Contracts**   | Locked via time-locked smart contracts |

---

## 🔄 Token Allocation

| Allocation Category     | Percentage | Amount (OCOS)      | Vesting / Lock |
|-------------------------|------------|--------------------|----------------|
| 🔹 Public Sale           | 15%        | 150,000,000        | No lock (DEX)  |
| 🔹 Strategic Reserve     | 20%        | 200,000,000        | 24-month linear vesting |
| 🔹 Team & Advisors       | 12%        | 120,000,000        | 12-month cliff, 18-month linear vesting |
| 🔹 Ecosystem & Rewards   | 18%        | 180,000,000        | Vesting pools + farming contracts |
| 🔹 Liquidity Provision   | 10%        | 100,000,000        | PancakeSwap & Binance bridge locked |
| 🔹 Treasury & Legal Ops  | 8%         | 80,000,000         | DAO-controlled multisig |
| 🔹 Partners & Grants     | 7%         | 70,000,000         | 6-month linear vesting |
| 🔹 Staking Incentives    | 5%         | 50,000,000         | Dynamic release based on APY ratios |
| 🔹 Airdrops & Bounty     | 5%         | 50,000,000         | Immediate release or task-based unlock |

---

## ⛓️ Vesting Contracts & Control

All allocations subject to lock are implemented using open-source audited vesting contracts. The release schedule is transparent and published on-chain.

- **Vesting Address Repository:** `/contracts/vesting/`
- **Multisig Controller:** `0xMultisigControlAddress...`
- **Auditable Events:** `event TokensReleased(address indexed beneficiary, uint256 amount);`

---

## 🔥 Deflation & Burn Mechanics

- **Manual Burn:** Tokens can be burned by the admin (DAO-governed) through the `burn()` function.
- **Auto Burn Trigger:** A portion of transaction fees and DEX liquidity LPs can be routed to the burn address periodically.
- **Burn Address:** `0x000000000000000000000000000000000000dEaD`

---

## 🧮 Real-Time Tracking

Real-time token allocation, claim history, and burned supply can be verified through:

- 🧭 **Block Explorer:** [bscscan.com](https://bscscan.com/token/0xa249ba073c01ceb65eafae7625d8f503c1f61c84)
- 📊 **Dashboard:** `https://dashboard.ocos.io/tokenomics`
- 🔍 **Oracle Feed:** Published every 12 hours to Chainlink node

---

## 🤝 Community Governance

OCOS token distribution may be **re-balanced or adjusted via DAO voting** only through proposals passed by OCOS holders using the `governance.ocos.io` portal.

- Minimum quorum: 5% of circulating supply
- Proposal delay: 2 days
- Execution time-lock: 24 hours post-vote

---

## 🧾 Compliance & Legal Statement

OCOS Token complies with BSC standards and was reviewed under applicable token compliance assessments. Allocation structures are designed to avoid centralized accumulation and promote transparency.

All core token flows are documented and visible in:
- `docs/legalCommitments.md`
- `docs/audit/certik-final-audit.md`

---

> **"The future of digital liquidity is transparent, programmable, and community-driven. OCOS leads the way by design."**  
> — _Ocoshy Nakomoto, Founder Vision_
