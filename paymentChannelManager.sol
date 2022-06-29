// SPDX-License-Identifier: GPL-3.0
// 3rd blockchain and DLT school - Pula

// improve the contracts to address security issues

pragma solidity ^0.8.7;

import "https://github.com/AndreaPinna/libraries/blob/main/signatures.sol";

contract Channel{
    address owner;
    address creator;

    constructor(address _owner, address _creator){
        owner = _owner; //msg.sender;
        creator = _creator;
    }       

    receive() payable external {
    }


    function getBalance() public view returns(uint256) {
        require(msg.sender == owner);
        return address(this).balance;
    }

    function payment(uint256 amount, bytes memory signature) public  {
        require(msg.sender == owner);
        require(Signatures.getSigner(amount,signature) == creator);
        payable(msg.sender).transfer(amount);
    }
    
    // create a selfdestruct to close the channel and recover the funds 
    // update the code to avoid double payments
    // update the code to avoid the issuance of overdrafts
    
}


contract PaymentChannelManager{

    address owner;
    uint256 public numberOfchannels;
    mapping(address => address) public channels;
    
    modifier onlyOwner(){
        require (msg.sender == owner, "Access denied");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    receive() payable external {

    }

    function createChannel(
        address payable recipient
        ) 
        public 
        onlyOwner
        returns(
            address channel
            ) 
        { 
        Channel c = new Channel(recipient, msg.sender);
        numberOfchannels += 1;
        channels[recipient] = address(c);
        return address(c);
    }

    function deposit(address recipient) payable public onlyOwner {
        address payable channel = payable(channels[recipient]);
        Channel c = Channel(channel);
        payable(address(c)).transfer(msg.value);

    }

    function createMessage(
        address recipient, 
        uint256 amount) 
        external 
        pure 
        returns(bytes32 message)
        {
            return Signatures.getMessage(recipient,amount);
        }
 
}
