// [Token Sale Smart Contract]

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenSale {
    address public owner;

    mapping(address => uint256) public balances;
    mapping(address => bool) public claimedRefund;

    enum SalePhase {NotStarted, Presale, PublicSale, Ended}
    SalePhase public currentPhase;

    uint256 public presaleCap;
    uint256 public publicSaleCap;
    uint256 public minContribution;
    uint256 public maxContribution;

    modifier onlyOwner() { require(msg.sender == owner, "Owner only"); _; }
    modifier onlyDuringSale() { require(currentPhase == SalePhase.Presale || currentPhase == SalePhase.PublicSale, "Sale not active"); _; }
    modifier onlyAfterSales() { require(currentPhase == SalePhase.Ended, "Sales still active"); _; }

    event EtherContributed(address indexed contributor, uint256 amount);
    event RefundClaimed(address indexed contributor, uint256 amount);

    constructor(uint256 _presaleCap, uint256 _publicSaleCap, uint256 _minContribution, uint256 _maxContribution) {
        owner = msg.sender;
        presaleCap = _presaleCap;
        publicSaleCap = _publicSaleCap;
        minContribution = _minContribution;
        maxContribution = _maxContribution;
        currentPhase = SalePhase.NotStarted;
    }

    function startPresale() external onlyOwner { 
        require(currentPhase == SalePhase.NotStarted, "Presale already started"); currentPhase = SalePhase.Presale; }

    function endPresale() external onlyOwner onlyDuringSale { 
        currentPhase = SalePhase.PublicSale; }

    function endSale() external onlyOwner onlyDuringSale { 
        currentPhase = SalePhase.Ended; }

    function contribute() external payable onlyDuringSale {
        uint256 remainingCap = (currentPhase == SalePhase.Presale) ? presaleCap - address(this).balance : publicSaleCap - address(this).balance;
        uint256 contribution = msg.value < minContribution ? 0 : msg.value > remainingCap ? remainingCap : msg.value;
        balances[msg.sender] += contribution;
        emit EtherContributed(msg.sender, contribution);
        if (address(this).balance == 0) currentPhase = SalePhase.Ended;
        if (currentPhase == SalePhase.Ended && balances[msg.sender] > 0 && !claimedRefund[msg.sender]) claimRefund();
    }

    function claimRefund() public onlyAfterSales {
        require(balances[msg.sender] > 0 && !claimedRefund[msg.sender], "No refund available");
        claimedRefund[msg.sender] = true;
        payable(msg.sender).transfer(balances[msg.sender]);
        emit RefundClaimed(msg.sender, balances[msg.sender]);
    }
}
