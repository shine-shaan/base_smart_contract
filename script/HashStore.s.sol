// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {HashStore} from "../src/HashStore.sol";

contract HashStoreScript is Script {
    HashStore public hashStore;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        hashStore = new HashStore();

        vm.stopBroadcast();
    }
}
