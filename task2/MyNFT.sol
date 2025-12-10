// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MyNFT is ERC721Enumerable {
    mapping(uint256 => string) public _tokenURIs;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function mint(string memory tokenURI_) external {
        uint256 tokenId = totalSupply() + 1;
        _tokenURIs[tokenId] = tokenURI_;
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        _requireOwned(tokenId);

        return _tokenURIs[tokenId];
    }

    // function _baseURI() internal pure override returns (string memory) {
    //     return "http://xxx/";
    // }
}
