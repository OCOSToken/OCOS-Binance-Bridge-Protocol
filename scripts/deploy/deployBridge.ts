import { ethers } from "hardhat";
import { OCOSBridge } from "../../typechain-types";

async function main() {
  console.log("🚀 Deploying OCOSBridge contract...");

  // Replace with actual values
  const binanceWallet = "0xBinanceWhitelistAddressHere";
  const ocosTokenAddress = "0xOcosTokenAddressHere";
  const liquidityManager = "0xLiquidityManagerAddressHere";

  const BridgeFactory = await ethers.getContractFactory("OCOSBridge");
  const bridge: OCOSBridge = await BridgeFactory.deploy(
    ocosTokenAddress,
    liquidityManager,
    binanceWallet
  );

  await bridge.deployed();
  console.log(`✅ OCOSBridge deployed at: ${bridge.address}`);
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
