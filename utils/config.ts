// utils/config.ts

/**
 * Global configuration file for OCOS-Binance-Bridge protocol
 * This config is used across scripts, deployment, and verification processes.
 */

export interface NetworkConfig {
  name: string;
  chainId: number;
  rpcUrl: string;
  explorerUrl: string;
  contracts: {
    OCOSBridge: string;
    LiquidityManager: string;
    ReserveVault: string;
    OCOS: string;
    BNB: string;
    StableToken: string; // e.g., USDT or BUSD
  };
  oracle: {
    chainlinkFeed: string;
  };
}

export const CONFIG: Record<string, NetworkConfig> = {
  mainnet: {
    name: "Binance Smart Chain Mainnet",
    chainId: 56,
    rpcUrl: "https://bsc-dataseed.binance.org/",
    explorerUrl: "https://bscscan.com",
    contracts: {
      OCOSBridge: "0x0000000000000000000000000000000000000000", // Replace with actual deployed address
      LiquidityManager: "0x0000000000000000000000000000000000000000",
      ReserveVault: "0x0000000000000000000000000000000000000000",
      OCOS: "0xa249bA073C01Ceb65Eafae7625d8f503C1f61C84",
      BNB: "0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c", // BTCB token as BNB representation
      StableToken: "0x55d398326f99059fF775485246999027B3197955", // USDT on BSC
    },
    oracle: {
      chainlinkFeed: "0x0567F2323251f0Aab15c8DfB1967E4e8A7D42aeE", // BNB/USD
    },
  },

  testnet: {
    name: "BSC Testnet",
    chainId: 97,
    rpcUrl: "https://data-seed-prebsc-1-s1.binance.org:8545/",
    explorerUrl: "https://testnet.bscscan.com",
    contracts: {
      OCOSBridge: "0x0000000000000000000000000000000000000000",
      LiquidityManager: "0x0000000000000000000000000000000000000000",
      ReserveVault: "0x0000000000000000000000000000000000000000",
      OCOS: "0x0000000000000000000000000000000000000000",
      BNB: "0x0000000000000000000000000000000000000000",
      StableToken: "0x0000000000000000000000000000000000000000",
    },
    oracle: {
      chainlinkFeed: "0x0000000000000000000000000000000000000000",
    },
  },
};
