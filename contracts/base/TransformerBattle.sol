pragma solidity ^0.4.20;

import "./TransformerUtils.sol";
import "../ref/SafeMath.sol";


contract TransformerBattle is TransformerUtils {

    uint private randNonce = 0;
    uint private attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }


}
