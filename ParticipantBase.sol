pragma solidity >=0.6.0;
import "DePoolLib.sol";
import "IProxy.sol";


contract ParticipantBase {

    // Dictionary of participants for rounds
    mapping (address => Participant) m_participants;

    function getOrCreateParticipant(address addr) internal view returns (Participant) {
        optional(Participant) optParticipant = m_participants.fetch(addr);
        if (optParticipant.hasValue()) {
            return optParticipant.get();
        }
        Participant newParticipant = Participant({
            roundQty: 0,
            reward: 0,
            vestingParts: 0,
            lockParts: 0,
            reinvest: true,
            withdrawValue: 0,
            vestingDonor: address(0),
            lockDonor: address(0)
        });
        return newParticipant;
    }

    function fetchParticipant(address addr) internal view returns (optional(Participant)) {
        return m_participants.fetch(addr);
    }

    function _setOrDeleteParticipant(address addr, Participant participant) internal {
        if (participant.roundQty == 0)
            delete m_participants[addr];
        else
            m_participants[addr] = participant;
    }
}
