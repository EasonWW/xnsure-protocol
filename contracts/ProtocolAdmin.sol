pragma solidity 0.5.17;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {
    SafeERC20,
    SafeMath
} from "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import {Math} from "@openzeppelin/contracts/math/Math.sol";

import "./Stogage.sol";

contract ProtocolAdmin is Storage {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    using Math for uint256;

    address public core;

    // NsureToken => vault
    mapping(address => IVault) public vaults;

    modifier onlyCore() {
        require(msg.sender == core, "Not Authorized, Only Core");
        _;
    }

    constructor(address _core){core = _core;}
}
