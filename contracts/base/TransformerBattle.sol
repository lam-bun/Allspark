pragma solidity ^0.4.20;

import "./TransformerUtils.sol";
import 'zeppelin-solidity/contracts/math/SafeMath.sol';


contract TransformerBattle is TransformerUtils {

    uint private randomNonce = 0;
    uint private attackVictoryProbability = 70;

    function fight(uint _transformerId, uint _enemyId) external onlyOwnerOf(_transformerId) {
        Transformer storage transformer = transfomers[_transformerId];
        Transformer storage enemyTransformer = transfomers[_enemyId];
        uint rand = mod(100);
        transformer.battle = transformer.battle.add(1);
        enemyTransformer.battle = enemyTransformer.battle.add(1);
        if (rand <= attackVictoryProbability) {
            transformer.level = transformer.level.add(1);
            transformer.victoryCount = transformer.victoryCount.add(1);
            enemyTransformer.defeatCount = enemyTransformer.defeatCount.add(1);
            transformer.matrix = _mergeMatrix(transformer.matrix, enemyTransformer.matrix);
        } else {
            enemyTransformer.level = enemyTransformer.level.add(1);
            enemyTransformer.victoryCount = enemyTransformer.victoryCount.add(1);
            transformer.defeatCount = transformer.defeatCount.add(1);
            enemyTransformer.matrix = _mergeMatrix(enemyTransformer.matrix, transformer.matrix);
        }
    }

    function mod(uint _transformerMatrix, uint _enemyMatrix) internal returns(uint) {
        randomNonce++;
        return uint(keccak256(now, msg.sender, randomNonce)) %
            (_transformerMatrix % attackVictoryProbability + _enemyMatrix % attackVictoryProbability);
    }

}
