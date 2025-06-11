# 🔐 SECURITY POLICY

**Project:** OCOS-Binance-Bridge-Pro  
**Maintained by:** OCOS Core Development Team  
**Scope:** Smart contracts, oracle scripts, vault mechanisms, deployment and liquidity protocols

---

## 🧭 Supported Versions

| Version        | Status     | Notes                                 |
|----------------|------------|----------------------------------------|
| `v1.0.0`       | ✅ Supported | Initial audited release with CertiK   |
| `v1.1.x`       | ✅ Supported | Includes liquidity automation upgrade |
| `v2.x.x`       | ⏳ Upcoming | DAO-governed bridge extensions        |

---

## 📩 Reporting a Vulnerability

We take the security of OCOS infrastructure very seriously.  
If you discover any security issue, **please report it directly and confidentially**.

### 📧 Report Contact:
- Email: `security@ocos.io`
- PGP Key: [Download Public Key](https://pgp.ocos.io/security.asc)
- Subject Line: `[SECURITY] Vulnerability Disclosure`

### 🛡️ Responsible Disclosure:
- We adhere to **Coordinated Vulnerability Disclosure (CVD)** practices.
- Do not create GitHub issues or public posts for security problems.
- Our team will respond within **72 hours** and work with you on a resolution.

---

## 🧪 Scope of Vulnerability Reports

We welcome reports related to:

- Smart Contract exploits (e.g. reentrancy, overflows)
- Oracle manipulation or feed disruption
- Improper permission or access control
- Liquidity mismanagement or vault bypasses
- Configuration exposures in `.env`, `config.ts`, or deployment flows

We **do not** consider the following as security vulnerabilities:

- Outdated documentation
- Lack of test coverage
- Denial of Service (DoS) via high gas loops (unless critical)
- Phishing attacks unrelated to OCOS infrastructure

---

## 👥 Rewards & Recognition

Depending on the severity and impact of the reported issue, OCOS may provide:

- Bug bounty rewards in **OCOS tokens or stablecoins**
- Public credit in our `SECURITY.md` or Hall of Fame
- Priority access to future OCOS testnet releases

---

## 🔐 Audit & Verification

All smart contracts under this repository are subject to professional audits.

| Auditor      | Scope                         | Status     | Report Location                      |
|--------------|-------------------------------|------------|--------------------------------------|
| CertiK       | OCOSBridge, Vault, Oracles     | ✅ Completed | `docs/audit/certik-final-audit.pdf`  |
| ChainGuardian | Liquidity and multisig logic | ⏳ Planned  | `docs/audit/2025-q3-guardian.pdf`    |

We use **static analysis, formal verification, and manual review** before every release.

---

## 🛠 Best Practices Followed

- 🧩 Use of `Ownable`, `ReentrancyGuard`, `SafeERC20`
- ⛓️ Time-locked functions and DAO approvals for liquidity
- 🔗 Oracle redundancy with Chainlink fallback
- 🔐 All admin operations gated by multi-sig wallets
- 📜 Open-source vesting and treasury contracts

---

## 📬 Questions or Clarifications

Please contact us at:

- `security@ocos.io` for vulnerability reporting
- `audit@ocos.io` for audit review access
- GitHub Issues for general non-sensitive questions

---

> **“Security is not optional. It is the foundation of user trust in any decentralized infrastructure.”**  
> — _OCOS Security Council_
