Andrea Pinna - Università di Cagliari.

Esercitazione di Solidity del 30 aprile 2019 del corso di APT di prof. Marchesi.

# **Contratti dimostrativi per la realizzazione di un GCC di base.**

Utilizzo.
I contratti Deck e Arena sono caricati sulla blockchain di test Ropsten con address:

* Deck: 0x42fd01c9a5a0c48a19c891bf22a16aa57459443f
* Arena: 0xfadf97ed2940cae55a4a3c8f40b63644bf9025b8

Compilare i due contratti Deck e Arena e caricare la loro istanza dai due address (su remix con "at address").

### Nel Deck
*  Per comprare una Card si deve impostare il "value" a 0.05 (in alto a destra su remix) e chiamare la funzione buyCard.
* Per autorizzare l'arena a leggere i dati delle Card usare setApprovalForAll del deck inserendo sia l'address dell'arena che true.
* Usare getCards() per conoscere le proprie cards e cardInfo(id) per conoscere i dati delle card.

#### Nell'arena:
* impostare una difesa con setDefender(id) inserendo l'id di una vostra carta.
* attaccare un avversario con attack(address,id) inserendo il suo address e l'id di una vostra carta.
* playerScore(address) per consocere il punteggio di un address.
* scores() per conoscere la lista degli address e il relativo punteggio.


### Address di prova da attaccare:

* Forte: 0x739F65CB2DF6ef7692b8423cf062E9a2243b40d8
* Debole: 0xF20541F9D55F49F9C90C00ffED353Dd87638f666


**Avviso: i contratti presentano bug. Proporre modifiche per migliorare l'implementazione.**

Spiegazioni nelle slide del corso.
Token ERC721 e librerire estratte da Openzeppelin:  https://github.com/OpenZeppelin/openzeppelin-solidity/tree/master/contracts/token/ERC721
