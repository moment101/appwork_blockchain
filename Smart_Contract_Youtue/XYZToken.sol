// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract XYZToken is IERC20 {
    address private _owner;
    uint private _totalSupply;
    mapping(address => uint) private _balanceOf;
    mapping(address => mapping(address => uint)) private _allowance;

    string public name = "ATPToken";
    string public symbol = "ATP";
    uint8 public immutable decimals = 18;

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address who) external view returns (uint256) {
        return _balanceOf[who];
    }

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256) {
        return _allowance[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(_balanceOf[msg.sender] >= value);
        require(to != address(0));
        _balanceOf[msg.sender] -= value;
        _balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        require(_balanceOf[from] >= value);
        require(_allowance[from][msg.sender] >= value);
        require(to != address(0));
        _balanceOf[from] -= value;
        _balanceOf[to] += value;
        _allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        require(spender != address(0));
        _allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function mint(uint256 value, address who) external onlyOwner {
        _totalSupply += value;
        _balanceOf[who] += value;
        emit Transfer(address(0), who, value);
    }

    function burn(uint256 value, address who) external onlyOwner {
        require(_balanceOf[who] >= value);
        _balanceOf[who] -= value;
        _totalSupply -= value;
        emit Transfer(who, address(0), value);
    }
}
