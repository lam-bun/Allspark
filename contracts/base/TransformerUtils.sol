pragma solidity ^0.4.20;

import "./TransformerFactory.sol";


contract TransformerUtils is TransformerFactory {

    uint16 private constant CHANGE_NAME_LEVEL_LIMIT = 30;

    uint private levelUpFee = 0.0005 ether;
    uint private changeNameFee = 0.001 ether;
    uint private randomMatrixFee = 0.001 ether;

    modifier onlyLevelOf(uint16 _level, uint _transformerId) {
        require(transformers[_transformerId].level >= _level);
        _;
    }

    modifier onlyOwnerOf(uint _transformerId) {
        require(msg.sender == transfomerToOwner[_transformerId]);
        _;
    }

    function changeLevelUpFee(uint _levelUpFee) external onlyOwner {
        levelUpFee = _levelUpFee;
    }

    function changeNameFee(uint _changeNameFee) external onlyOwner {
        changeNameFee = _changeNameFee;
    }

    function changeName(uint _transformerId, string _newName) external
    onlyOwnerOf(_transformerId) onlyLevelOf(CHANGE_NAME_LEVEL_LIMIT, _transformerId) {
        transformers[_transformerId].name = _newName;
    }

    function changeName(uint _transformerId, string _newName, uint _fee) external onlyOwnerOf(_transformerId) payable {
        require(msg.value == _fee);
        transformers[_transformerId].name = _newName;
    }

    function levelUp(uint _transformerId) external onlyOwnerOf(_transformerId) {
        transformers[_transformerId].level++;
    }

    function levelUp(uint _transformerId, uint _fee) external onlyOwnerOf(_transformerId) payable {
        require(msg.value == _fee);
        transformers[_transformerId].level++;
    }
}
