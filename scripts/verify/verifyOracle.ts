import { run } from "hardhat";

async function main() {
  // Replace with actual deployed contract address
  const contractAddress = "0xYourDeployedContractAddressHere";

  // Replace with actual constructor arguments used during deployment
  const constructorArgs = [
    "0xVaultAddress",        // reserveVault
    "0xStableTokenAddress",  // stableToken (e.g. USDT)
    "0xBNBTokenAddress",     // bnbToken (e.g. WBNB)
    "0xOCOSTokenAddress"     // ocosToken
  ];

  try {
    console.log("⏳ Verifying OCOSReserveMonitor contract on Etherscan...");

    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: constructorArgs,
    });

    console.log("✅ Contract successfully verified!");
  } catch (error) {
    console.error("❌ Verification failed:", error);
  }
}

main().catch((error) => {
  console.error("❌ Script execution failed:", error);
  process.exit(1);
});
