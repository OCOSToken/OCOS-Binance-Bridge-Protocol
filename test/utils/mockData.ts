// test/utils/mockData.ts

/**
 * Mock data module for OCOS Reserve Monitoring tests.
 * Simulates token balances, reserve vault states, and timestamps
 * to verify Proof of Reserve logic in OCOSReserveMonitor.sol
 */

export interface MockTokenBalance {
  tokenAddress: string;
  symbol: string;
  decimals: number;
  initialBalance: string; // in wei
}

export interface MockReserveSnapshot {
  timestamp: number;
  stableBalance: string;
  bnbBalance: string;
  ocosBalance: string;
}

export const mockTokens: MockTokenBalance[] = [
  {
    tokenAddress: "0x0000000000000000000000000000000000001000",
    symbol: "USDT",
    decimals: 18,
    initialBalance: "50000000000000000000000", // 50,000 USDT
  },
  {
    tokenAddress: "0x0000000000000000000000000000000000002000",
    symbol: "BNB",
    decimals: 18,
    initialBalance: "300000000000000000000", // 300 BNB
  },
  {
    tokenAddress: "0x0000000000000000000000000000000000003000",
    symbol: "OCOS",
    decimals: 18,
    initialBalance: "1000000000000000000000000", // 1,000,000 OCOS
  },
];

export const expectedSnapshots: MockReserveSnapshot[] = [
  {
    timestamp: 1718100000,
    stableBalance: "50000000000000000000000",
    bnbBalance: "300000000000000000000",
    ocosBalance: "1000000000000000000000000",
  },
  {
    timestamp: 1718103600,
    stableBalance: "52000000000000000000000",
    bnbBalance: "295000000000000000000",
    ocosBalance: "990000000000000000000000",
  },
];

/**
 * Utility function to simulate passage of time (in seconds)
 */
export const advanceTime = async (seconds: number, ethers: any) => {
  await ethers.provider.send("evm_increaseTime", [seconds]);
  await ethers.provider.send("evm_mine", []);
};
