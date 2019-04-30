pragma solidity ^0.5.0;

import "./Deck.sol";

contract Arena {
    
    struct Defender{
        bool ready;
        uint32 cardId;
    }
    
    address[] _players;
    uint256[] _orderedScores;
    
    address payable  addressDeck;
    address arenaOwner;
    
    mapping(address => uint256) _scores;
    mapping(address => Defender) _defenders;
    
    
    modifier onlyReady(address _defender){
        require(_defenders[_defender].ready,"Players must set the defender");
        _;
    }
    
    
    modifier onlyCardOwner(uint32 id){
        Deck mydeck = Deck(addressDeck);
        require (mydeck.ownerOf(id)==msg.sender, "use one of your card");
        _;
    }
        
    modifier onlyOwner(){
        require(msg.sender==arenaOwner, "only the owner can do this");
        _;
    }
    
    constructor() public{
        arenaOwner = msg.sender;
    }
    
    function setDeck(address payable _address) public onlyOwner {
        addressDeck = _address;
    }
     
       
    function setDefender(uint32 id) public onlyCardOwner(id) returns(uint32, bool) {
        _defenders[msg.sender].cardId=id;
        _defenders[msg.sender].ready=true;
        _players.push(msg.sender);
        return (_defenders[msg.sender].cardId, _defenders[msg.sender].ready); 
    }
    
    function attack(address _defender, uint32 id) public onlyReady(_defender) onlyReady(msg.sender) onlyCardOwner(id) returns(string memory) {
       Deck mydeck = Deck(addressDeck);
       uint8 Astrench;
       uint8 Adefence;
       uint8 Dstrench;
       uint8 Ddefence;
       (Astrench,Adefence) = mydeck.cardInfo(id);
       (Dstrench,Ddefence) = mydeck.cardInfo(_defenders[_defender].cardId);
       if(Astrench/Ddefence >=  Dstrench/Adefence){
            _scores[msg.sender]=_scores[msg.sender]+1;
            _updateScores();
            return "You Win! :D";
       }
       else {
           _scores[_defender]=_scores[_defender]+1;
           _updateScores();
           return "You Lose! :(";
       }
    }
    
    function playerScore(address _aPlayer) public view returns(uint256 score){
        return _scores[_aPlayer];
    }
    
    function scores() public view returns(address[] memory thePlayers,uint256[] memory theScore){
        return (_players, _orderedScores);
    }

    function _updateScores() private {
        _orderedScores.length=_players.length;
        uint32 i;
        for(i=0;i<_players.length;i++){
            _orderedScores[i]=_scores[_players[i]];
        }        
    }      
}
