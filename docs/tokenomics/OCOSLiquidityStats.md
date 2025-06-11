# 📊 OCOS Liquidity Statistics – Tokenomics Report

**Location:** `docs/tokenomics/OCOSLiquidityStats.csv`  
**Generated on:** June 2025  
**Compiled by:** OCOS Tokenomics & Research Unit  
**Reference Token:** `OCOS` (BEP20)  
**Reference Chains:** Binance Smart Chain (BNB), Ethereum (ETH)

---

## 📌 Overview

The `OCOSLiquidityStats.csv` file provides structured, time-series data reflecting the real-time liquidity composition, pool distribution, exchange depth, and market-making activities surrounding the OCOS token across decentralized and centralized ecosystems.

The data serves as a key resource for:

- Financial audits & reserve validation  
- DEX liquidity provisioning reports  
- Market behavior analytics  
- Long-term issuance vs. collateral ratio analysis  
- Strategic governance decision-making

---

## 📁 CSV Structure

Each row in the CSV represents a **daily snapshot** of the OCOS token’s liquidity metrics.

| Column Header           | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| `Date`                  | UTC timestamp of the recorded snapshot                                      |
| `Chain`                 | Blockchain network where liquidity was analyzed (e.g., BNB, ETH)            |
| `DEX`                   | DEX platform (e.g., PancakeSwap, Uniswap, Sushiswap)                        |
| `Pool`                  | Trading pair pool (e.g., OCOS/BNB, OCOS/USDT)                               |
| `TotalLiquidityUSD`     | Total USD equivalent liquidity in the pool                                 |
| `OCOSReserve`           | Amount of OCOS tokens in the pool                                           |
| `CounterReserveToken`   | Token paired with OCOS (e.g., BNB, USDT)                                    |
| `CounterReserveAmount`  | Amount of counter token in the liquidity pool                               |
| `PriceOCOS`             | Price of 1 OCOS token in USD at snapshot time                               |
| `Volume24hUSD`          | Total 24-hour trading volume in USD                                         |
| `PoolFeeTier`           | Liquidity provider fee rate (e.g., 0.3%, 0.05%)                             |
| `OracleDeviation%`      | Deviation from Chainlink oracle price (risk analysis)                       |
| `BinancePairMirror`     | Whether a mirrored Binance pair exists (true/false)                        |
| `LiquidityProvider`     | Entity or wallet responsible for initial pool provisioning                 |
| `ProofOfReserveTxHash`  | TX hash linking to on-chain proof of reserve at snapshot                   |

---

## 🔍 Example Row

Date,Chain,DEX,Pool,TotalLiquidityUSD,OCOSReserve,CounterReserveToken,CounterReserveAmount,PriceOCOS,Volume24hUSD,PoolFeeTier,OracleDeviation%,BinancePairMirror,LiquidityProvider,ProofOfReserveTxHash
2025-06-10,BNB,PancakeSwap,OCOS/BNB,745000,215000,BNB,102.5,3.465,204000,0.25%,-0.3%,true,0x1234abcd…,0xaaa1bb22cc33…

---

## 🔐 Data Integrity & Verification

- 📎 All rows are cryptographically hash-locked on the BNB chain via `ProofOfReserve` events.
- 📦 The CSV file is digitally signed by the OCOS treasury wallet.
- ✅ Fully compatible with CertiK audit reports and liquidity attestations.

---

## 🧠 Usage

Researchers, developers, investors, and auditors can use this dataset for:

- Liquidity mining ROI analysis  
- Real-time on-chain asset monitoring  
- Mirror pair tracking between CEX and DEX  
- Oracle vs. market slippage audits  
- Strategic decisions on token rebasing and burns  

---

## 📬 Notes

- Raw CSV file is located here: [`OCOSLiquidityStats.csv`](./OCOSLiquidityStats.csv)
- For graphical visualizations and time-series trends, refer to `/diagrams/liquidity-curve.png`
- Dataset is refreshed every 24h by the OCOS Liquidity Monitor Oracle

---

> “Liquidity is the bloodstream of a decentralized economy. OCOS ensures its pools remain deep, balanced, and on-chain verifiable — every day.”

— OCOS Tokenomics Research Division

