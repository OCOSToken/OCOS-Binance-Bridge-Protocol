// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SafeERC20Custom
 * @dev Təhlükəsiz ERC20 əməliyyatları üçün uyğunlaşdırılmış kitabxana.
 * OpenZeppelin SafeERC20 əsasında yaradılmışdır.
 */

library SafeERC20Custom {
    function safeTransfer(address token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(bytes4(keccak256("transfer(address,uint256)")), to, value));
    }

    function safeTransferFrom(address token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(bytes4(keccak256("transferFrom(address,address,uint256)")), from, to, value));
    }

    function safeApprove(address token, address spender, uint256 value) internal {
        require(
            (value == 0) || (_getAllowance(token, msg.sender, spender) == 0),
            "SafeERC20Custom: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(bytes4(keccak256("approve(address,uint256)")), spender, value));
    }

    function _getAllowance(address token, address owner, address spender) private view returns (uint256) {
        (bool success, bytes memory data) = token.staticcall(
            abi.encodeWithSelector(bytes4(keccak256("allowance(address,address)")), owner, spender)
        );
        require(success && data.length >= 32, "SafeERC20Custom: failed to get allowance");
        return abi.decode(data, (uint256));
    }

    function _callOptionalReturn(address token, bytes memory data) private {
        (bool success, bytes memory returndata) = token.call(data);
        require(success, "SafeERC20Custom: low-level call failed");

        if (returndata.length > 0) {
            require(abi.decode(returndata, (bool)), "SafeERC20Custom: ERC20 operation did not succeed");
        }
    }
}
