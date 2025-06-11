// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title OCOS Reserve Monitor Oracle
/// @notice Tracks and reports reserve balances backing OCOS liquidity
/// @author OCOS

interface IToken {
    function balanceOf(address account) external view returns (uint256);
}

contract OCOSReserveMonitor {
    address public admin;
    address public reserveVault;
    address public stableToken; // USDT, BUSD, etc.
    address public bnbToken;
    address public ocosToken;

    struct ReserveSnapshot {
        uint256 timestamp;
        uint256 stableBalance;
        uint256 bnbBalance;
        uint256 ocosBalance;
    }

    ReserveSnapshot[] public snapshots;

    event ReserveProofGenerated(
        uint256 indexed timestamp,
        uint256 stableBalance,
        uint256 bnbBalance,
        uint256 ocosBalance
    );

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor(
        address _vault,
        address _stableToken,
        address _bnbToken,
        address _ocosToken
    ) {
        admin = msg.sender;
        reserveVault = _vault;
        stableToken = _stableToken;
        bnbToken = _bnbToken;
        ocosToken = _ocosToken;
    }

    /// @notice Generates a new reserve snapshot and emits a proof event
    function generateReserveProof() external onlyAdmin {
        uint256 stableBal = IToken(stableToken).balanceOf(reserveVault);
        uint256 bnbBal = IToken(bnbToken).balanceOf(reserveVault);
        uint256 ocosBal = IToken(ocosToken).balanceOf(reserveVault);

        snapshots.push(ReserveSnapshot({
            timestamp: block.timestamp,
            stableBalance: stableBal,
            bnbBalance: bnbBal,
            ocosBalance: ocosBal
        }));

        emit ReserveProofGenerated(block.timestamp, stableBal, bnbBal, ocosBal);
    }

    /// @notice Returns the latest reserve snapshot
    function getLatestSnapshot() external view returns (ReserveSnapshot memory) {
        require(snapshots.length > 0, "No data");
        return snapshots[snapshots.length - 1];
    }

    /// @notice Returns total number of snapshots
    function getSnapshotCount() external view returns (uint256) {
        return snapshots.length;
    }

    /// @notice Admin can update reserve vault if needed
    function updateVault(address newVault) external onlyAdmin {
        reserveVault = newVault;
    }
}
