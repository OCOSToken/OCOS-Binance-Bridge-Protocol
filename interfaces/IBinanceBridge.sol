// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IBinanceBridge
 * @dev Interface for OCOS ↔ Binance bridge communication.
 * Provides standard method definitions for deposit, withdrawal, and external sync.
 */
interface IBinanceBridge {
    
    /// @notice Deposit OCOS tokens on behalf of a Binance user.
    /// @param user The wallet address to receive OCOS tokens.
    /// @param amount The amount of OCOS tokens to deposit.
    function depositFromBinance(address user, uint256 amount) external;

    /// @notice Withdraw OCOS tokens from the user back to Binance CEX.
    /// @param user The wallet address whose tokens will be withdrawn.
    /// @param amount The amount of OCOS tokens to withdraw.
    function withdrawToBinance(address user, uint256 amount) external;

    /// @notice Verifies an off-chain transaction hash issued by Binance.
    /// @param txHash The off-chain Binance transaction hash.
    /// @return success A boolean indicating verification status.
    function validateBinanceTx(bytes32 txHash) external view returns (bool success);

    /// @notice Checks whether an address is a whitelisted Binance wallet.
    /// @param wallet The address to validate.
    /// @return status True if wallet is authorized by the bridge.
    function isWhitelistedBinanceWallet(address wallet) external view returns (bool status);

    /// @notice Emits event upon successful synchronization.
    /// Typically called internally after deposit or withdrawal.
    function emitBridgeSyncLog(bytes32 txId, string calldata status) external;
}
