// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// 用 solidity 实现整数转罗马数字
// - 范围：1 <= num <= 3999
// 符号    值
// I       1
// V       5
// X       10
// L       50
// C       100
// D       500
// M       1000
contract Int2RomanNumeral {
 // 处理千位数
    function _convertThousands(uint256 number) private pure returns (string memory) {
        if (number == 0) return "";
        
        bytes memory result;
        for (uint256 i = 0; i < number; i++) {
            result = abi.encodePacked(result, "M");
        }
        return string(result);
    }
    
    // 处理百位数
    function _convertHundreds(uint256 number) private pure returns (string memory) {
        if (number == 9) return "CM";
        if (number == 8) return "DCCC";
        if (number == 7) return "DCC";
        if (number == 6) return "DC";
        if (number == 5) return "D";
        if (number == 4) return "CD";
        if (number == 3) return "CCC";
        if (number == 2) return "CC";
        if (number == 1) return "C";
        return "";
    }
    
    // 处理十位数
    function _convertTens(uint256 number) private pure returns (string memory) {
        if (number == 9) return "XC";
        if (number == 8) return "LXXX";
        if (number == 7) return "LXX";
        if (number == 6) return "LX";
        if (number == 5) return "L";
        if (number == 4) return "XL";
        if (number == 3) return "XXX";
        if (number == 2) return "XX";
        if (number == 1) return "X";
        return "";
    }
    
    // 处理个位数
    function _convertOnes(uint256 number) private pure returns (string memory) {
        if (number == 9) return "IX";
        if (number == 8) return "VIII";
        if (number == 7) return "VII";
        if (number == 6) return "VI";
        if (number == 5) return "V";
        if (number == 4) return "IV";
        if (number == 3) return "III";
        if (number == 2) return "II";
        if (number == 1) return "I";
        return "";
    }
    
    function toRoman(uint256 number) public pure returns (string memory) {
        require(number > 0 && number <= 3999, "Number must be between 1 and 3999");
        
        uint256 thousands = number / 1000;
        uint256 hundreds = (number % 1000) / 100;
        uint256 tens = (number % 100) / 10;
        uint256 ones = number % 10;
        
        return string(abi.encodePacked(
            _convertThousands(thousands),
            _convertHundreds(hundreds),
            _convertTens(tens),
            _convertOnes(ones)
        ));
    }
}