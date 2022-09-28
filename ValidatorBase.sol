pragma solidity >=0.6.0;

import "DePoolLib.sol";
import "IProxy.sol";

contract ValidatorBase {
    // Address of the validator wallet
    address m_validatorWallet;

    constructor(address validatorWallet) internal {
        m_validatorWallet = validatorWallet;
    }

    modifier onlyValidatorContract {
        require(msg.sender == m_validatorWallet, Errors.IS_NOT_VALIDATOR);
        _;
    }
}