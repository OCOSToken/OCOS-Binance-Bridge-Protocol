import { ethers } from "hardhat";
import { expect } from "chai";
import { Contract } from "ethers";

describe("🧪 BinanceLiquidityManager", function () {
  let liquidityManager: Contract;
  let ocosToken: Contract;
  let bnbToken: Contract;
  let owner: any;
  let addr1: any;
  let addr2: any;

  const initialOCOS = ethers.utils.parseEther("1000000"); // 1 million OCOS
  const initialBNB = ethers.utils.parseEther("500"); // 500 BNB

  beforeEach(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    // Deploy mock OCOS token
    const OCOSMock = await ethers.getContractFactory("OCOSTokenMock");
    ocosToken = await OCOSMock.deploy("OCOS", "OCOS", initialOCOS);
    await ocosToken.deployed();

    // Deploy mock BNB token
    const BNBMock = await ethers.getContractFactory("MockToken");
    bnbToken = await BNBMock.deploy("BNB", "BNB", initialBNB);
    await bnbToken.deployed();

    // Deploy Liquidity Manager
    const Manager = await ethers.getContractFactory("BinanceLiquidityManager");
    liquidityManager = await Manager.deploy(ocosToken.address, bnbToken.address);
    await liquidityManager.deployed();

    // Transfer OCOS and BNB to manager contract
    await ocosToken.transfer(liquidityManager.address, ethers.utils.parseEther("250000")); // 25% OCOS
    await bnbToken.transfer(liquidityManager.address, ethers.utils.parseEther("100")); // 100 BNB
  });

  it("should hold initial OCOS and BNB balances", async function () {
    const ocosBal = await ocosToken.balanceOf(liquidityManager.address);
    const bnbBal = await bnbToken.balanceOf(liquidityManager.address);

    expect(ocosBal).to.equal(ethers.utils.parseEther("250000"));
    expect(bnbBal).to.equal(ethers.utils.parseEther("100"));
  });

  it("should allow owner to sync liquidity", async function () {
    const tx = await liquidityManager.connect(owner).syncLiquidity();
    await tx.wait();

    const synced = await liquidityManager.lastSynced();
    expect(synced).to.be.gt(0);
  });

  it("should revert sync from non-owner", async function () {
    await expect(
      liquidityManager.connect(addr1).syncLiquidity()
    ).to.be.revertedWith("Not authorized");
  });

  it("should return correct liquidity reserves", async function () {
    const reserves = await liquidityManager.getLiquidityStatus();
    expect(reserves.ocos).to.equal(ethers.utils.parseEther("250000"));
    expect(reserves.bnb).to.equal(ethers.utils.parseEther("100"));
  });

  it("should emit LiquiditySynced event", async function () {
    await expect(liquidityManager.connect(owner).syncLiquidity())
      .to.emit(liquidityManager, "LiquiditySynced")
      .withArgs(owner.address);
  });
});
