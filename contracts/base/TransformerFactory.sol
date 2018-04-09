pragma solidity ^0.4.20;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';


contract TransformerFactory is Ownable {

    using SafeMath for uint16;

    uint private matrixDigits = 16;
    uint private matrixModulus = 10 ** matrixDigits;
    Transfomer[] public transfomers;

    event NewTransfomer(uint transfomerId, string name, uint matrix);

    struct Transfomer {
        string name;
        uint matrix;
        uint16 level;
        uint16 battle;
        uint16 victoryCount;
        uint16 defeatCount;
    }

    mapping (uint => address) public transfomerToOwner;
    mapping (address => Transfomer[]) public ownerTransfomers;

    modifier onlyOwnerOf(uint _transformerId) {
        require(msg.sender == transfomerToOwner[_transformerId]);
        _;
    }

    function trasnfer(string _name) public {
        uint randomMatrix = _generateMatrix(_name);
        _transfer(_name, randomMatrix);
    }

    function _transfer(string _name, uint _matrix) internal {
        Transfomer memory transfomer = Transfomer(_name, _matrix, 0, 0, 0, 0);
        ownerTransfomers[msg.sender].push(transfomer);
        uint transfomerId = transfomers.push(transfomer) - 1;
        NewTransfomer(transfomerId, _name, _matrix);
    }

    function _mergeMatrix(uint _matrix, uint _targetMatrix) internal {
        return uint(keccak256(_matrix, _targetMatrix)) % matrixModulus;
    }

    function _generateMatrix(string _str) private view returns (uint) {
        return uint(keccak256(_str)) % matrixModulus;
    }

}
