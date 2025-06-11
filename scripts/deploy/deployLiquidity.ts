// scripts/deploy/deployLiquidity.ts

import { ethers } from "hardhat";

async function main() {
  console.log("🔁 Deploying BinanceLiquidityManager...");

  const [deployer] = await ethers.getSigners();
  console.log(`👤 Deployer address: ${deployer.address}`);

  // Contract factory
  const LiquidityManager = await ethers.getContractFactory("BinanceLiquidityManager");

  // Deploy with constructor arguments if needed
  const liquidityManager = await LiquidityManager.deploy();

  await liquidityManager.deployed();

  console.log(`✅ BinanceLiquidityManager deployed at: ${liquidityManager.address}`);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
