import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import TrieMap "mo:base/TrieMap";
import Hash "mo:base/Hash";
import Int "mo:base/Int";
import Blob "mo:base/Blob";
import IterType "mo:base/IterType";
import Types "./types";
import MemberHelper "modules/member_helper";
import ProposalHelper "modules/proposal_helper";

actor class DAO() = this {
  public type Result<Ok, Err> = Result.Result<Ok, Err>;

  public type MemberRole = Types.MemberRole;
  public type Member = Types.Member;
  public type Members = Types.Members;

  public type Proposal = Types.Proposal;
  public type Proposals = Types.Proposals;
  public type ProposalType = Types.ProposalType;

  public type CreateProposalOk = Types.CreateProposalOk;
  public type CreateProposalErr = Types.CreateProposalErr;
  public type CreateProposalResult = Types.CreateProposalResult;

  public type VoteOk = Types.VoteOk;
  public type VoteErr = Types.VoteErr;
  public type VoteResult = Types.VoteResult;

  let members : Members = HashMap.HashMap<Principal, Member>(10, Principal.equal, Principal.hash);

  let proposals : Proposals = TrieMap.TrieMap<Nat, Proposal>(Nat.equal, Hash.hash);
  var nextProposalId : Nat = 0;

  // START - Member functions
  public shared ({ caller }) func createContributeMember(name : Text) : async Result<(), Text> {
    //Check if caller is not anoymous
    // if(Principal.equal(caller, Principal.fromText("2vxsx-fae"))) {
    //   return #err("Anonymous users are not allowed to add members.");
    // };

    // TODO: Validate that the member is locked in 1 ICP
    if(false) {
      return #err("Lock 1 ICP to become a member");
    };

    let memberResult = members.get(caller);

    //If member already exists:
    // Case 1 - If Volunteer update it to Contributor
    // Case 2 - Otherwise Return error
    switch(memberResult) {
      case(null) {};
      case(?m) {
        if(m.roles.size() == 1 and m.roles[0] == #Volunteer) {
          members.put(caller, {
            name = name;
            roles = [#Contributor];
          });

          return #ok;
        } else {
          return #err("A member with the same identifier already exists.");
        };
      };
    };

    // Check for open Newcomer proposal, if exists -> #Reject
    let newcomerProposalsResult : ?(Nat, Proposal) = ProposalHelper.getNewcomerProposalRequest(proposals, caller);

    switch(newcomerProposalsResult) {
      case(null) {

      };
      case(?newcomerProposalsResult) {
        let updatedProposal : Proposal = {
          id = newcomerProposalsResult.1.id;
          createdBy = newcomerProposalsResult.1.createdBy;
          status = #Rejected;
          description = newcomerProposalsResult.1.description;
          proposalType = newcomerProposalsResult.1.proposalType;
          instruction = newcomerProposalsResult.1.instruction;
          votes = newcomerProposalsResult.1.votes;
          voters = newcomerProposalsResult.1.voters;
        };

        proposals.put(newcomerProposalsResult.0, updatedProposal);
      };
    };

    let member = MemberHelper.createMember(members, name, caller, [#Contributor]);

    return #ok;
  };

  public shared ({ caller}) func createNewcomerProposal(name : Text) : async Result<(), Text> {
    let result = await ProposalHelper.createNewcomerProposal(name, caller, proposals, members, nextProposalId);

    if(Result.isOk(result)) {
      nextProposalId := Nat.add(nextProposalId, 1);
    };

    return result;
  };

  public query func getMember(principal : Principal) : async Result<Member, Text> {
    let memberData : ?Member = members.get(principal);

    switch (memberData) {
      case (null) {
        return #err("Member not found.");
      };
      case (?member) {
        return #ok(member);
      };
    };
  };

  public query func getAllMembers() : async [Member] {
    let entries = members.entries();
    let memberIter : Iter.Iter<Member> = {
      next = func () : ?Member {
        switch (entries.next()) {
          case (?(_, member)) { return ?member; };
          case null { return null; };
        };
      };
    };

    return Iter.toArray<Member>(memberIter);
  };

  // This function just clears all roles of a member
  public shared ({ caller }) func removeMember() : async Result<(), Text> {
    let memberData : ?Member = members.get(caller);

    switch (memberData) {
      case (null) {
        return #err("Member not found.");
      };
      case (?member) {
        let a : Member = {
          name = member.name;
          roles = [];
        };

        members.put(caller, a);

        return #ok();
      };
    };

    return #ok();
  };
  // END - Member functions

  // START - Proposal functions
  public shared ({ caller }) func createProposal(proposalType : ProposalType, description : Text, instruction : ?Text) : async CreateProposalResult {
    let member = members.get(caller);

    // Check if the caller is a DAO member
    switch(member) {
      case(null) {
        return #err(#NotDAOMember);
      };
      case(?m) {
        // If Volunteer return error
        if(Array.find<MemberRole>(m.roles, func x = x == #Volunteer) != null) {
          return #err(#NotAllowed);
        }
      };
    };

    // Check if instruction is required but not provided
    if (ProposalHelper.isInstructionRequired(proposals, proposalType) and instruction == null) {
        return #err(#InstructionRequired);
    };

    let proposal = ProposalHelper.createNewProposal(proposals, nextProposalId, proposalType, description, caller, instruction);

    // Increment the nextProposalId
    nextProposalId := Nat.add(nextProposalId, 1);

    // Return success with the new proposal's ID
    return #ok(proposal.id);
  };

  public query func getAllProposals() : async [(Nat, Proposal)] {
    let entries = proposals.entries();

    return Iter.toArray<(Nat, Proposal)>(entries);
  };

  public query func getProposal(id : Nat) : async ?Proposal {
    // Retrieve the proposal using the given ID
    return proposals.get(id);
  };

  public shared ({ caller }) func vote(id : Nat, vote : Bool) : async VoteResult {
    return await ProposalHelper.vote(id, vote, members, caller, proposals);
  };
  // END - Proposal functions

  public shared query (msg) func getAuthenticatedMemberData() : async Result<Member, Text> {
    let member = members.get(msg.caller);

    switch(member) {
      case(null) {
        return #err("No member data found for the current user.");
      };
      case(?m) {
        return #ok(m);
      };
    };
  };

  public shared query (msg) func hasNewcomerProposalRequest() : async Bool {
    let newcomerProposalsResult : ?(Nat, Proposal) = ProposalHelper.getNewcomerProposalRequest(proposals, msg.caller);

    switch(newcomerProposalsResult) {
      case(null) {
        return false;
      };
      case(?i) {
        return true;
      }
    }
  };

  public shared ({ caller }) func whoami() : async Principal {
    caller;
  };
};