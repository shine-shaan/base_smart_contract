// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title HashStore
 * @dev 데이터의 해시값을 블록체인에 기록하고 검증하는 간단한 컨트랙트
 */

import "@openzeppelin/contracts/access/Ownable.sol";

contract HashStore is Ownable {
    constructor() Ownable(msg.sender) {}

    // 해시 저장 여부를 확인하기 위한 매핑 (해시값 => 저장 여부)
    mapping(bytes32 => bool) private hashes;

    // 해시가 저장될 때 발생하는 이벤트
    event HashStored(bytes32 indexed hashValue, address indexed sender);

    /**
     * @dev 새로운 해시값을 블록체인에 저장합니다.
     * @param _hash 저장할 keccak256 해시값
     */
    function storeHash(bytes32 _hash) public onlyOwner {
        require(!hashes[_hash], "Hash already exists!"); // 이미 존재하는 해시인지 확인

        hashes[_hash] = true;
        emit HashStored(_hash, msg.sender);
    }

    /**
     * @dev 특정 해시값이 저장되어 있는지 확인합니다.
     * @param _hash 확인할 해시값
     * @return 저장되어 있으면 true, 아니면 false
     */
    function verifyHash(bytes32 _hash) public view returns (bool) {
        return hashes[_hash];
    }

    /**
     * @dev (편의 기능) 문자열 데이터를 해시값으로 변환해주는 유틸리티 함수
     * @param _data 변환할 문자열
     * @return 생성된 bytes32 해시값
     */
    function computeHash(string memory _data) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_data));
    }
}
