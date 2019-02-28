pragma solidity ^0.4.23;

import './CBDICO.sol';
import './CBDMisc.sol';
import './SafeMath.sol';

contract TronMarket is killable  {

    using SafeMath for uint256;

    address ownerMultisig;
    mapping(address=>uint) blockedTill;

    trcToken tokenId;

    constructor(trcToken _tokenId) public {
        ownerMultisig = msg.sender;
        owner = msg.sender;
        tokenId = _tokenId;

        currentICOPhase = 1;
        addICOPhase("Phase1", 10000000, 10000);
        addICOPhase("Phase2", 10000000, 20000);
        addICOPhase("Phase3", 10000000, 50000);
        addICOPhase("Phase4", 10000000, 100000);
        addICOPhase("Phase5", 10000000, 100000);
    }

    function () payable public{
        createTokens();
    }

    function createTokens() payable public {
        ICOPhase storage i = icoPhases[currentICOPhase];
        require(i.saleOn == true);

        uint256 tokens = msg.value.mul(i.RATE);

        (msg.sender).transferToken(tokens, tokenId);
    }
}

