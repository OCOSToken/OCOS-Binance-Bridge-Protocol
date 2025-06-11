// Filename: test/bridge.test.ts

import { expect } from "chai";
import { ethers } from "hardhat";

describe("OCOSBridge Contract", function () {
  let bridge: any;
  let token: any;
  let owner: any;
  let binanceWallet: any;
  let user: any;

  beforeEach(async function () {
    [owner, binanceWallet, user] = await ethers.getSigners();

    // Deploy mock OCOS token
    const Token = await ethers.getContractFactory("MockOCOSToken");
    token = await Token.deploy("OCOS Token", "OCOS", 18);
    await token.deployed();

    // Deploy bridge contract
    const Bridge = await ethers.getContractFactory("OCOSBridge");
    bridge = await Bridge.deploy(token.address, binanceWallet.address);
    await bridge.deployed();

    // Mint and approve tokens for testing
    await token.mint(binanceWallet.address, ethers.utils.parseUnits("1000", 18));
    await token.connect(binanceWallet).approve(bridge.address, ethers.utils.parseUnits("1000", 18));
  });

  it("should allow deposit from Binance wallet", async function () {
    const depositAmount = ethers.utils.parseUnits("100", 18);

    await expect(
      bridge.connect(binanceWallet).depositFromBinance(user.address, depositAmount)
    )
      .to.emit(bridge, "Deposited")
      .withArgs(user.address, depositAmount);

    const userBalance = await token.balanceOf(user.address);
    expect(userBalance).to.equal(depositAmount);
  });

  it("should revert deposit from unauthorized wallet", async function () {
    const amount = ethers.utils.parseUnits("50", 18);

    await expect(
      bridge.connect(user).depositFromBinance(user.address, amount)
    ).to.be.revertedWith("Only Binance wallet can deposit");
  });

  it("should allow withdrawal to Binance wallet", async function () {
    const withdrawAmount = ethers.utils.parseUnits("30", 18);

    // Mint tokens to user and approve bridge
    await token.mint(user.address, withdrawAmount);
    await token.connect(user).approve(bridge.address, withdrawAmount);

    await expect(
      bridge.connect(user).withdrawToBinance(withdrawAmount)
    )
      .to.emit(bridge, "Withdrawn")
      .withArgs(user.address, withdrawAmount);

    const bridgeBalance = await token.balanceOf(bridge.address);
    expect(bridgeBalance).to.equal(withdrawAmount);
  });

  it("should revert withdrawal if amount not approved", async function () {
    const withdrawAmount = ethers.utils.parseUnits("10", 18);

    await expect(
      bridge.connect(user).withdrawToBinance(withdrawAmount)
    ).to.be.revertedWith("ERC20: transfer amount exceeds allowance");
  });
});
