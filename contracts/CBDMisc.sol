pragma solidity ^0.4.23;

import './CBDICO.sol';

contract killable is ICO {

    function killContract() ownerOnly external{
        selfdestruct(ownerMultisig);
    }
}
