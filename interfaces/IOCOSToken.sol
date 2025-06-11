// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IOCOSToken Interface
/// @notice Standardized interface for OCOS BEP-20 token interactions across bridge and liquidity contracts
/// @dev Compatible with both ERC-20 and BEP-20 implementations

interface IOCOSToken {
    
    // --- Basic ERC20 Interface ---
    
    function name() external view returns (string memory);
    
    function symbol() external view returns (string memory);
    
    function decimals() external view returns (uint8);
    
    function totalSupply() external view returns (uint256);
    
    function balanceOf(address account) external view returns (uint256);
    
    function transfer(address recipient, uint256 amount) external returns (bool);
    
    function allowance(address owner, address spender) external view returns (uint256);
    
    function approve(address spender, uint256 amount) external returns (bool);
    
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // --- Events ---
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // --- OCOS-Specific Extensions ---

    /// @notice Mints new tokens to a specific address (only bridge or owner can call)
    function mint(address to, uint256 amount) external;

    /// @notice Burns tokens from a specific address (used for withdrawals and reserve sync)
    function burn(address from, uint256 amount) external;

    /// @notice Freezes a wallet (anti-bot or blacklist mechanism)
    function freeze(address user) external;

    /// @notice Unfreezes a wallet
    function unfreeze(address user) external;

    /// @notice Checks if the address is frozen
    function isFrozen(address user) external view returns (bool);
}
