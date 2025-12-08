// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// 任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
// 1.合约包含以下标准 ERC20 功能：
// 2.balanceOf：查询账户余额。
// 3.transfer：转账。
// 4.approve 和 transferFrom：授权和代扣转账。
// 5.使用 event 记录转账和授权操作。
// 6.提供 mint 函数，允许合约所有者增发代币。
// 提示：
// - 使用 mapping 存储账户余额和授权信息。
// - 使用 event 定义 Transfer 和 Approval 事件。
// - 部署到sepolia 测试网，导入到自己的钱包

contract MyToken {
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _decimals,
        uint256 initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = initialSupply * 10 ** _decimals;

        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Cannot transfer to zero address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0), "Cannot approve to zero address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        require(from != address(0), "From zero address");
        require(to != address(0), "To zero address");

        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Insufficient allowance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

    function mint(address to, uint value) external onlyOwner returns (bool) {
        require(to != address(0), "Cannot mint to zero address");

        totalSupply += value;
        balanceOf[to] += value;

        emit Transfer(address(0), to, value);
        return true;
    }

    function burn(uint256 amount) public {
        require(
            balanceOf[msg.sender] >= amount,
            "Insufficient balance to burn"
        );

        totalSupply -= amount;
        balanceOf[msg.sender] -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }
}
