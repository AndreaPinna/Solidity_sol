pragma solidity ^0.5.1;

contract Parrot{
    enum colors{red, yellow, brown}
    address owner;
    colors color;
    
    string [] repertoire;
        
    modifier onlyOwner(){
        require(msg.sender==owner, "-*-*-The parrot peck at you-*-*-");
        _;
    }
    
    modifier onlyNotEmpty(){
        require(repertoire.length>0,"-*-*-The parrot peck at you-*-*-");
        _;
    }
    
    constructor() public {
        owner=msg.sender;    
        color=colors(uint(address(this))%3);
    }
    
    function repeat(string memory message) public view onlyOwner returns(string memory theMessage){
        return message;
    }
    
    function speak() public view onlyOwner onlyNotEmpty returns(string memory theMessage){
        uint index=now%repertoire.length;
        return repertoire[index];
    }

    
    function learn(string memory message) public onlyOwner returns(string memory theMessage){
        repertoire.push(message);
        return message;
    }
     
    
    function myColor() public view onlyOwner returns(colors){
        return color;
    }
}


contract Pirate{
    address owner;
    address []  myParrots;
    
    
    modifier onlyOwner(){
        require(msg.sender==owner, "-*-*-Access deined-*-*-");
        _;
    }
    
    constructor() public {
        owner=msg.sender;    
    }
    
    function getParrotCount() public view  returns(uint Parrots){
        return myParrots.length;
    }
    
    function getParrotAddress(uint i) public view returns (address){
        return myParrots[i];
    }
    
    function tameParrot() public returns(address theParrot) { 
        Parrot p = new Parrot();
        myParrots.push(address(p));
        return address(p);
    }
    
    function talkParrot(string memory sentence, address aParrot) public view returns(string memory){
        Parrot p = Parrot(aParrot);
        return p.repeat(sentence);
        
    }
    
    function teachParrot(string memory sentence, address aParrot) public returns(string memory){
        Parrot p = Parrot(aParrot);
        return p.learn(sentence);
    }
    
    function listenParrot(address aParrot) public view returns(string memory){
        Parrot p = Parrot(aParrot);
        return p.speak();
    }
    
    function colorParrot(address aParrot) public view returns(uint color){
        Parrot p = Parrot(aParrot);
        return uint(p.myColor());
    }
    
    
    
}
