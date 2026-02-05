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
        
        console2.log("=== Deployment Configuration ===");
        console2.log("RPC URL:", vm.rpcUrl("base_sepolia"));
        console2.log("Deployer address:", vm.addr(deployerPrivateKey));
        console2.log("EntryPoint address:", entrypointAddress);

        
        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy Kernel contract
        Kernel kernel = new Kernel(IEntryPoint(entrypointAddress));
        
        console2.log("=== Deployment Result ===");
        console2.log("Kernel deployed at:", address(kernel));
        console2.log("");
        console2.log("=== Verification Command ===");
        console2.log("forge verify-contract \\");
        console2.log("  --chain-id", block.chainid, "\\");
        console2.log(
            string.concat(
                "  --constructor-args ",
                vm.toString(abi.encode(entrypointAddress)),
                " \\"
            )
        );
        console2.log("  --etherscan-api-key no-key-needed \\");
        console2.log("  --verifier-url https://chainscan.0g.ai/api \\");
        console2.log("  ", address(kernel), "\\");
        console2.log("  src/Kernel.sol:Kernel");
        
        vm.stopBroadcast();
    }
}