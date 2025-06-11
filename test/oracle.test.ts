import { ethers } from "hardhat";
import { expect } from "chai";
import { Contract } from "ethers";

describe("OCOSReserveMonitor", function () {
  let admin: any;
  let reserveVault: any;
  let stableToken: Contract;
  let bnbToken: Contract;
  let ocosToken: Contract;
  let monitor: Contract;

  beforeEach(async function () {
    [admin, reserveVault] = await ethers.getSigners();

    // Mock ERC20 tokens
    const MockERC20 = await ethers.getContractFactory("MockERC20");
    stableToken = await MockERC20.deploy("USDT", "USDT", 18);
    bnbToken = await MockERC20.deploy("BNB", "BNB", 18);
    ocosToken = await MockERC20.deploy("OCOS", "OCOS", 18);

    // Mint tokens to reserve vault address
    await stableToken.mint(reserveVault.address, ethers.utils.parseUnits("50000", 18));
    await bnbToken.mint(reserveVault.address, ethers.utils.parseUnits("100", 18));
    await ocosToken.mint(reserveVault.address, ethers.utils.parseUnits("1000000", 18));

    // Deploy OCOSReserveMonitor
    const Monitor = await ethers.getContractFactory("OCOSReserveMonitor");
    monitor = await Monitor.deploy(
      reserveVault.address,
      stableToken.address,
      bnbToken.address,
      ocosToken.address
    );
  });

  it("should generate a valid reserve proof snapshot", async function () {
    const tx = await monitor.generateReserveProof();
    const receipt = await tx.wait();

    const event = receipt.events?.find((e: any) => e.event === "ReserveProofGenerated");

    expect(event).to.not.be.undefined;
    expect(event.args?.stableBalance).to.equal(ethers.utils.parseUnits("50000", 18));
    expect(event.args?.bnbBalance).to.equal(ethers.utils.parseUnits("100", 18));
    expect(event.args?.ocosBalance).to.equal(ethers.utils.parseUnits("1000000", 18));
  });

  it("should return the latest snapshot", async function () {
    await monitor.generateReserveProof();
    const snapshot = await monitor.getLatestSnapshot();

    expect(snapshot.stableBalance).to.equal(ethers.utils.parseUnits("50000", 18));
    expect(snapshot.bnbBalance).to.equal(ethers.utils.parseUnits("100", 18));
    expect(snapshot.ocosBalance).to.equal(ethers.utils.parseUnits("1000000", 18));
  });

  it("should allow admin to update the vault address", async function () {
    const [_, newVault] = await ethers.getSigners();
    await monitor.updateVault(newVault.address);
    expect(await monitor.reserveVault()).to.equal(newVault.address);
  });

  it("should fail if non-admin tries to update the vault", async function () {
    const [_, nonAdmin] = await ethers.getSigners();
    await expect(
      monitor.connect(nonAdmin).updateVault(nonAdmin.address)
    ).to.be.revertedWith("Not authorized");
  });
});
