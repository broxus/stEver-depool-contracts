pragma solidity >=0.6.0;
import "DePoolLib.sol";
import "IProxy.sol";

contract ConfigParamsBase {
    function getCurValidatorData() virtual pure internal returns (uint256 hash, uint32 utime_since, uint32 utime_until) {
        (TvmCell cell, bool ok) = tvm.rawConfigParam(34);
        require(ok, InternalErrors.ERROR508);
        TvmSlice s = cell.toSlice();
        (, utime_since, utime_until) = s.decode(uint8, uint32, uint32);
        hash = utime_since;
    }

    function getPrevValidatorHash() virtual pure internal returns (uint256 hash) {
        (TvmCell cell, bool ok) = tvm.rawConfigParam(32);
        require(ok, InternalErrors.ERROR507);
        TvmSlice s = cell.toSlice();
        (, hash) = s.decode(uint8, uint32);
    }

    function roundTimeParams() virtual pure internal returns (
        uint32 validatorsElectedFor,
        uint32 electionsStartBefore,
        uint32 electionsEndBefore,
        uint32 stakeHeldFor
    ) {
        bool ok;
        (validatorsElectedFor, electionsStartBefore, electionsEndBefore, stakeHeldFor, ok) = tvm.configParam(15);
        require(ok, InternalErrors.ERROR509);
    }

    function getMaxStakeFactor() virtual pure internal returns (uint32) {
        (TvmCell cell, bool ok) = tvm.rawConfigParam(17);
        require(ok, InternalErrors.ERROR516);
        TvmSlice s = cell.toSlice();
        s.loadTons();
        s.loadTons();
        s.loadTons();
        return s.decode(uint32);
    }

    function getElector() virtual pure internal returns (address) {
        (TvmCell cell, bool ok) = tvm.rawConfigParam(1);
        require(ok, InternalErrors.ERROR517);
        TvmSlice s = cell.toSlice();
        uint256 value = s.decode(uint256);
        return address.makeAddrStd(-1, value);
    }
}