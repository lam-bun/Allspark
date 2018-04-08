pragma solidity ^0.4.19;

contract TransformerFactory {

  uint matrixDigits = 16;
  uint matrixModulus = 10 ** matrixDigits;
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
  mapping (address => Transfomer[]) ownerTransfomers;

  function _transfer(string _name, uint _matrix) internal {
    Transfomer memory transfomer = Transfomer(_name, _matrix, 0, 0, 0, 0);
    ownerTransfomers[msg.sender].push(transfomer);
    uint transfomerId = transfomers.push(transfomer) - 1;
    NewTransfomer(transfomerId, _name, _matrix);
  }

  function _generateMatrix(string _str) private view returns (uint) {
    uint randomMatrix = uint(keccak256(_str)) % matrixModulus;
    randomMatrix = randomMatrix - randomMatrix % 100;
    return randomMatrix;
  }

  function trasnfer(string _name) public {
    uint randomMatrix = _generateMatrix(_name);
    _transfer(_name, randomMatrix);
  }

}
