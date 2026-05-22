// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

import "forge-std/Test.sol"; 
import "../contracts/BinhaToken.sol";

/**
 * @title BinhaTokenTest
 * @author felipetojal
 * @notice This contract runs tests on BinhaToken.sol
 */
contract BinhaTokenTest is Test {
    BinhaToken internal token;
    uint256 internal bin;
    // Hardhat automatically gives a fake address
    address owner = address(this);

    // Function setUp runs automatically before the tests
    function setUp() public {
        token = new BinhaToken();
        bin = uint256(10 ** token.decimals());
    }

    // Auxiliary function to compare strings
    function compareString(string memory string1, string memory string2) internal pure returns (bool) {
        return keccak256(bytes(string1)) == keccak256(bytes(string2));
    }

    // Testing the name() function 
    function testName() public view {
        require(
            compareString(token.name(), "BINHA"),
            "TOKEN NAME IS INCORRECT"
         );
    }

    // Testing the symbol() function
    function testSymbol() public view {
        require(
            compareString(token.symbol(), "BIN"),
            "TOKEN NAME IS INCORRECT"
        );
    }

    // Testing the decimals() function
    function testDecimals() public view {
        assertEq(token.decimals(), 18);
    }

    // Testing the totalSupply() function
    function testTotalSupply() public {
        assertEq(token.totalSupply(), 1_000_000_000 * uint256(10 ** token.decimals()));
    }

    // Testing the balanceOf() function
    function testBalanceOf() public {
        assertEq(token.balanceOf(owner), token.totalSupply());
    }

    // Testing the transfer() function
    function testTransfer() public {
        address nick = address(0x123);
        address playmobil = address (0x789);

        // Transfering tokens from owner to playmobil.
        bool success = token.transfer(playmobil, 4_000_000 * bin);
        require (
            success,
            "FAILED TO TRANSFER TOKEN TO PLAYMOBIL"
        );
        assertEq(token.balanceOf(playmobil), 4_000_000 * bin);
        uint256 owner_balance = (1_000_000_000 - 4_000_000) * bin;
        assertEq(token.balanceOf(owner), owner_balance);

        // Transfering tokens from owner to nick.
        success = token.transfer(nick, 1_000_000 * bin);
        require (
            success,
            "FAILED TO TRANSFER TOKEN TO NICK"
        );
        assertEq(token.balanceOf(nick), 1_000_000 * bin);
        owner_balance -= (1_000_000 * bin);
        assertEq(token.balanceOf(owner), owner_balance);
    }

    // Function to test allownce() and approve()
    function testAllowanceAndApprove() public {
        address target = address(0x111);
        uint256 amount = 2_000 * bin;
        
        bool success = token.approve(target, amount);
        require(
            success,
            "FAILED TO APPROVE ALLOWANCE"
        );
        assertEq(token.allowance(owner, target), amount);
    }

    // Function to test transferFrom()
    function testTransferFrom() public {
        address someone = address(0x109);
        uint256 allowed = 3_000 * bin;
        uint256 spend = 1_500 * bin;
        address chillGuy = address(0x011);

        bool success = token.approve(someone, allowed);
        require(
            success,
            "FAILED TO APPROVE ALLOWANCE"
        );
        assertEq(token.allowance(owner, someone), allowed);

        vm.prank(someone);
        success = token.transferFrom(owner, chillGuy, spend);
        require(
            success,
            "FAILED TO TRANSFER FROM"
        );
        assertEq(token.balanceOf(chillGuy), spend);
        assertEq(token.balanceOf(owner), token.totalSupply() - spend);
    }
}