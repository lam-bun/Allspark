pragma solidity ^0.4.20;

import './TransformerFactory.sol';

contract TransformerUtils is TransformerFactory {

  uint16 constant changeNameLevelLimit = 30;

  uint levelUpFee = 0.0005 ether;
  uint changeNameFee = 0.001 ether;
  uint randomMatrixFee = 0.001 ether;

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

  function changeNameFee(uint _changeNameFee) {
    changeNameFee = _changeNameFee;
  }

  function changeName(uint _transformerId, string _newName) external onlyOwnerOf(_transformerId) onlyLevelOf(changeNameLevelLimit, _transformerId) {
    transformers[_transformerId].name = _newName;
  }

  function changeName(uint _transformerId, string _newName, uint _fee) onlyOwnerOf(_transformerId) external payable {
    require(msg.value == _fee);
    transformers[_transformerId].name = _newName;
  }

  function levelUp(uint _transformer) external onlyOwnerOf(_transformerId) {
    transformers[_transformerId].level++;
  }

  function levelUp(uint _transformer, uint _fee) onlyOwnerOf(_transformerId) external payable {
    require(msg.value == _fee);
    transformers[_transformerId].level++;
  }
}
