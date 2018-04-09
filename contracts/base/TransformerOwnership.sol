pragma solidity ^0.4.20;

import "./TransformerFactory.sol";
import "zeppelin-solidity/contracts/token/ERC721/ERC721.sol";


contract TransformerOwnership is TransformerFactory, ERC721 {

    mapping (uint => address) transfomerApprovals;

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return getTransfomerCount(_owner);
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return transfomerToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        transfomerApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function takeOwnership(uint256 _tokenId) public {
        require(transfomerApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        transfomerToOwner[_tokenId] = _to;
        ownerTransfomers[_to].push(transfomers[_tokenId]);
        // TODO remove transfomer from _from
        Transfer(_from, _to, _tokenId);
    }

}
