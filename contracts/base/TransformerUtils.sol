pragma solidity ^0.4.19;

import "./TransformerFactory.sol"

contract TransformerUtils is TransformerFactory {

  uint16 constant changeNameLimit = 30;

  uint levelUpFee = 0.0005 ether;
  uint changeNameFee = 0.001 ehter;
  uint randomMatrix = 0.001 ehter;

  modifier onlyLevelOf(uint16 _level, uint _transformerId) {
    require(transformers[_transformerId].level >= _level);
    _;
  }

  modifier onlyOwnerOf(uint _transformerId) {
    require(msg.sender == transfomerToOwner[_transformerId]);
    _;
  }

  function changeLevelUpFee(uint _levelUpFee) {
    levelUpFee = _levelUpFee;
  }

  function changeNameFee(uint _levelUpFee) {
    levelUpFee = _levelUpFee;
  }

  function changeName(uint _transformerId, string _newName) onlyOwnerOf(_transformerId) onlyLevelOf(changeNameLimit, _transformerId) {
    transformers[_transformerId].name = _newName;
  }

  function changeName(uint _transformerId, string _newName, uint _fee)() onlyOwnerOf(_transformerId) {
    require(msg.value == _fee);
    transformers[_transformerId].name = _newName;
  }

  function levelUp(uint _transformer) onlyOwnerOf(_transformerId){
    transformers[_transformerId].level++;
  }

  function levelUp(uint _transformer, uint _fee) onlyOwnerOf(_transformerId) {
    require(msg.value == _fee);
    transformers[_transformerId].level++;
  }
}
