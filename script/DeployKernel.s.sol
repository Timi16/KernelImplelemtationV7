// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {Kernel} from "../src/Kernel.sol";
import {IEntryPoint} from "../src/interfaces/IEntryPoint.sol";

contract DeployKernel is Script {
    function run() external {
        // Load environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address entrypointAddress = vm.envAddress("ENTRYPOINT_ADDRESS");
        
        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy Kernel contract
        Kernel kernel = new Kernel(IEntryPoint(entrypointAddress));
        
        console2.log("Kernel deployed at:", address(kernel));
        console2.log("EntryPoint address:", entrypointAddress);
        console2.log("Deployer address:", vm.addr(deployerPrivateKey));
        
        vm.stopBroadcast();
    }
}