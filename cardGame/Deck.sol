pragma solidity ^0.5.0;

import "./ERC721.sol";

contract Deck is ERC721{

    struct Card{
        uint8 attack; 
        uint8 defence;
    }

    mapping(uint => Card) private _cards;
    uint32 lastid;

    struct Player{
        uint32[] cardVect;
    }

    mapping(address => Player) private _players;

    modifier checkValue(){
            require(msg.value==0.05 ether,"Each card costs 0.05 Ether. Please pay exactly 0.05 ether to buy");
        _;
    }


    modifier onlyCardAllowed(uint32 id){
        require(ownerOf(id)==msg.sender ||
                getApproved(id)==msg.sender ||
                isApprovedForAll(ownerOf(id),msg.sender) ,
                "You don't own this card");
        _;
    }

    function buyCard() payable checkValue public {
        lastid=lastid+1;
        _mint(msg.sender,lastid);
        
        uint8 _attack=uint8(uint32(now)%256);//pseudorandom
        uint8 _defence=uint8((111*uint32(now))%256);
        _cards[lastid].attack=_attack;
        _cards[lastid].defence=_defence;
        _players[msg.sender].cardVect.push(lastid);        
    }

    
    function cardInfo(uint32 id) public onlyCardAllowed(id) view returns(uint8 attack, uint8 defence) {
        attack = _cards[id].attack;
        defence = _cards[id].defence;  
    }
    
    function getCards() public view returns(uint32[] memory){
        return(_players[msg.sender].cardVect);   
    }
    


}
