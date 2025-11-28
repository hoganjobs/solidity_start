// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// 创建一个名为Voting的合约，包含以下功能：
// - 一个mapping来存储候选人的得票数
// - 一个vote函数，允许用户投票给某个候选人
// - 一个getVotes函数，返回某个候选人的得票数
// - 一个resetVotes函数，重置所有候选人的得票数
contract Voting {
    mapping(address => uint256) public candidateVotes;

    address[] public candidateList;

    function vote(address key) public {
        candidateVotes[key] += 1;
    }

    function getVotes(address key) public view returns (uint256) {
        return candidateVotes[key];
    }

    function resetVotes() public {
        uint256 len = candidateList.length;
        for (uint256 i = 0; i < len; i++) {
            address candidate = candidateList[i];
            candidateVotes[candidate] = 0;
        }
    }
}
