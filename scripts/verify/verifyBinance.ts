// verify/verifyBinance.ts
import { run } from "hardhat";

async function main() {
  const OCOSBridgeAddress = "0xDeployedOCOSBridgeAddress"; // Əvəzlə
  const constructorArgs = [
    "0xReserveVaultAddress",     // reserveVault
    "0xStableTokenAddress",      // USDT, BUSD və s.
    "0xBNBTokenAddress",         // Wrapped BNB və ya native
    "0xOCOSTokenAddress"         // OCOS token ünvanı
  ];

  console.log("🔍 Verifying OCOSBridge at:", OCOSBridgeAddress);

  try {
    await run("verify:verify", {
      address: OCOSBridgeAddress,
      constructorArguments: constructorArgs,
    });
    console.log("✅ Verification complete.");
  } catch (err: any) {
    console.error("❌ Verification failed:", err.message || err);
  }
}

main().catch((error) => {
  console.error("🚨 Script execution error:", error);
  process.exitCode = 1;
});
