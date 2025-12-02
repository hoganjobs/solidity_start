// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// 反转字符串 (Reverse String)
// - 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
contract ReverseString {
    function reverse(string memory str) public pure returns (string memory) {
        // 将字符串转换为 bytes 进行字符级操作
        bytes memory strBytes = bytes(str);
        uint256 length = strBytes.length;

        // 字符串为空或只有一个字符，直接返回
        if (length <= 1) {
            return str;
        }

        // 结果数组
        bytes memory result = new bytes(length);

        // 反转字符
        for (uint256 i = 0; i < length; i++) {
            result[i] = strBytes[length - 1 - i];
        }

        return string(result);
    }
}
