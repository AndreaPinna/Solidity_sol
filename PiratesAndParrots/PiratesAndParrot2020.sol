// SPDX-License-Identifier: CC-BY-4.0
/// @title Pirates And Parrots - Basic version
/// @author Andrea Pinna

pragma solidity ^0.6.0;

contract Parrot{
    address owner;  
    string [] repertoire;
    
    modifier onlyOwner(){
        require(msg.sender==owner, "-*-*-The parrot bites your nose-*-*-");
        _;
	}
	constructor() public {
        owner=msg.sender;    
    }
   
	function repeat(string memory sentence) public view onlyOwner   returns(string memory the_parrot_says){
		return sentence;
	}
	
	function learn(string memory message) public onlyOwner returns(string memory theMessage){
        repertoire.push(message);
        return message;
    }
    
    function speak() public view onlyOwner returns (string memory theMessage){
        uint index=now%repertoire.length;
        return repertoire[index];
    }
    
    

}


contract Pirate{
    address myParrot;
    address [] myParrots;
    
    constructor() public {}
   
    function tameParrot() public returns(address theParrot) { 
		Parrot p = new Parrot();
		myParrots.push(address(p));
		return address(address(p));
    }
    
    function getParrotAddress() public view returns (address){
        return myParrot;
    }
    
    //overloading 
    function getParrotAddress(uint i) public view returns (address){
        return myParrots[i];  
    }
    
    function getParrotCount() public view  returns(uint Parrots){
        return myParrots.length;
    }
    
    function talkParrot(string memory sentence, address aParrot)			public view returns(string memory){
        Parrot p = Parrot(aParrot);
        return p.repeat(sentence);   
    }
    
    function teachParrot(string memory sentence, address aParrot) public returns(string memory){
        Parrot p = Parrot(aParrot);
        
        try p.learn(sentence) returns (string memory _sentence){
            return _sentence;
        }
        catch{// Error(string memory ){
           return "HEY: This parrot is not yours!!!" ;
        }
        

    }
    
    function listenParrot(address aParrot) public view returns(string memory){
        Parrot p = Parrot(aParrot);
        return p.speak();
    }   
    
  
}
