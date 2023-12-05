import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import TrieMap "mo:base/TrieMap";
module {
    public type HashMap<K, V> = HashMap.HashMap<K, V>;
    public type TrieMap<K, V> = TrieMap.TrieMap<K, V>;

    public type MemberRole = {
        #AssetOwner;
        #Contributor;
        #FinancialSupporter;
        #Volunteer;
    };

    public type Member = {
        name : Text;
        roles : [MemberRole];
    };
    public type Members = HashMap<Principal, Member>;
    
    public type Result<A, B> = Result.Result<A, B>;

    public type ProposalStatus = {
        #Open;
        #Accepted;
        #Rejected;
    };

    public type ProposalType = {
        #DecisionMaking;
        #DocumentManagement;
        #Newcomer;
        // TODO: #FundsTransfer
        // TODO: #RolesUpdate
    };

    public type Proposal = {
        id : Nat;
        createdBy : Principal;
        proposalType : ProposalType;
        description : Text;
        status : ProposalStatus;
        instruction : ?Text;
        votes : Int;
        voters : [Principal];
        // TODO: endsAt 
    };

    public type Proposals = TrieMap<Nat, Proposal>;

    public type CreateProposalOk = Nat;

    public type CreateProposalErr = {
        #NotAllowed;
        #NotDAOMember;
        #InstructionRequired;
    };

    public type CreateProposalResult = Result<CreateProposalOk, CreateProposalErr>;

    public type VoteOk = {
        #ProposalAccepted;
        #ProposalRefused;
        #ProposalOpen;
    };

    public type VoteErr = {
        #ProposalNotFound;
        #AlreadyVoted;
        #ProposalEnded;
        #NotEnoughTokens;
        #NotDAOMember;
        #NotAllowed;
    };

    public type VoteResult = Result<VoteOk, VoteErr>;

};
