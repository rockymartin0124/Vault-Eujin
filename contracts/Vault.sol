//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault {
    address public tknContract;
    address public auth;
    address public owner;
    uint256 public totalBalance;
    uint256 public unlockedBalance;

    modifier onlyAuthor() {
        require(msg.sender == auth, "You are not author!");
        _;
    }
    modifier onlyOwner() {
        require(owner != address(0), "Owner is not set!");
        require(msg.sender == owner, "You are not owner!");
        _;
    }
    constructor() {
        auth = msg.sender;
    }

    function withdraw(address acc, uint256 amt) public onlyOwner {
        require(amt > 0, "Invalid amount!");

        IERC20(tknContract).transfer(acc, amt);
    }

    function setTkn(address tokenAddress) public onlyAuthor {
        tknContract = tokenAddress;
    }

    function setOwner(address _owner) public onlyAuthor {
        require(owner == address(0), "Owner already set!");
        owner = _owner;
    }

}
