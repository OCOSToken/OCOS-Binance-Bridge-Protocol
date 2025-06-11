// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title OCOSReserveVault
 * @dev This contract safely holds OCOS tokens and BNB as reserves, emits proof-of-reserve logs, and enables only the authorized bridge or owner to move assets.
 * @author OCOS
 */

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OCOSReserveVault is Ownable {
    /// @notice OCOS token address
    IERC20 public OCOSToken;

    /// @notice Authorized bridge contract
    address public bridgeContract;

    /// @notice Event: emitted for proof of reserve
    event ProofOfReserve(uint256 timestamp, uint256 OCOSBalance, uint256 BNBAmount);

    /// @notice Event: funds withdrawn
    event FundsWithdrawn(address indexed to, uint256 ocosAmount, uint256 bnbAmount);

    constructor(address _ocosToken) {
        require(_ocosToken != address(0), "Invalid OCOS token address");
        OCOSToken = IERC20(_ocosToken);
    }

    /// @notice Set authorized bridge contract (one-time or owner-controlled)
    function setBridgeContract(address _bridgeContract) external onlyOwner {
        require(_bridgeContract != address(0), "Invalid bridge address");
        bridgeContract = _bridgeContract;
    }

    /// @notice Emit reserve proof (can be called by anyone)
    function emitProofOfReserve() external {
        uint256 ocosBalance = OCOSToken.balanceOf(address(this));
        uint256 bnbBalance = address(this).balance;
        emit ProofOfReserve(block.timestamp, ocosBalance, bnbBalance);
    }

    /// @notice Withdraw funds to Binance bridge or owner
    function withdrawReserves(address to, uint256 ocosAmount, uint256 bnbAmount) external {
        require(msg.sender == owner() || msg.sender == bridgeContract, "Unauthorized access");
        require(to != address(0), "Invalid recipient");

        if (ocosAmount > 0) {
            require(OCOSToken.balanceOf(address(this)) >= ocosAmount, "Insufficient OCOS");
            OCOSToken.transfer(to, ocosAmount);
        }

        if (bnbAmount > 0) {
            require(address(this).balance >= bnbAmount, "Insufficient BNB");
            payable(to).transfer(bnbAmount);
        }

        emit FundsWithdrawn(to, ocosAmount, bnbAmount);
    }

    /// @notice Accept BNB deposits
    receive() external payable {}
}
