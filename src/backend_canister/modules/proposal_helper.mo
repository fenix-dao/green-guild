import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Int "mo:base/Int";
import Option "mo:base/Option";
import Result "mo:base/Result";
import MemberHelper "member_helper";
import Types "../types";

module {
  public type Result<Ok, Err> = Result.Result<Ok, Err>;
  public type Proposal = Types.Proposal;
  public type Proposals = Types.Proposals;
  public type ProposalType = Types.ProposalType;
  public type VoteResult = Types.VoteResult;
  public type Members = Types.Members;
  public type MemberRole = Types.MemberRole;
  public type ProposalStatus = Types.ProposalStatus;

  public func createNewcomerProposal(name : Text, caller : Principal, proposals : Proposals, members : Members, nextProposalId : Nat) : async Result<(), Text> {
    // if(Principal.equal(caller, Principal.fromText("2vxsx-fae"))) {
    //   return #err("Anonymous users are not allowed to add members.");
    // };
    
    if(members.get(caller) != null) {
      return #err("A member with the same identifier already exists.");
    };

    let proposalsIter = proposals.vals();
    let existingNewcomerProposal = Iter.filter<(Proposal)>(proposalsIter, func (item : Proposal) : Bool {
      item.createdBy == caller and item.proposalType == #Newcomer;
    });

    switch(existingNewcomerProposal.next()) {
      case(null) {
      };
      case(_) {
        return #err("Newcomer proposal already exists.");
      };
    };

    let proposal = createNewProposal(proposals, nextProposalId, #Newcomer, name # " wants to join as a volunteer.", caller, ?name);

    return #ok();
  };

  public func vote(id : Nat, vote : Bool, members : Members, caller : Principal, proposals : Proposals) : async VoteResult {
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

    // Retrieve the proposal
    switch (proposals.get(id)) {
      case (null) {
        // Proposal not found
        return #err(#ProposalNotFound);
      };
      case (?proposal) {
        // Check if the proposal is still open
        if (proposal.status != #Open) {
          return #err(#ProposalEnded);
        };
        
        // Check if the caller has already voted
        if (Array.indexOf<Principal>(caller, proposal.voters, Principal.equal) != null) {
          return #err(#AlreadyVoted);
        };

        // TODO: Voting power based on member score...

        // Process the vote
        let voteChange = if (vote) { 1 } else { -1 };
        let updatedVotes = Int.add(proposal.votes, voteChange);
        let updatedVoters = Array.append<Principal>(proposal.voters, [caller]);
        var updatedStatus : ProposalStatus = proposal.status;

        let majorityRequired = members.size() / 2; // More than 50%

        // Update proposal status
        if (updatedVotes > majorityRequired) { // Assuming 10 votes are needed for acceptance
          updatedStatus := #Accepted;
        } else if (Int.abs(updatedVotes) >= majorityRequired) { // Assuming -10 votes for refusal
          updatedStatus := #Rejected;
        };

        let updatedProposal : Proposal = {
          id = proposal.id;
          createdBy = proposal.createdBy;
          status = updatedStatus;
          description = proposal.description;
          proposalType = proposal.proposalType;
          instruction = proposal.instruction;
          votes = updatedVotes;
          voters = updatedVoters;
        };

        proposals.put(updatedProposal.id, updatedProposal);

        // Return vote result
        switch(updatedStatus) {
          case(#Open) {
            return #ok(#ProposalOpen);
          };
          case(#Accepted) {
            // TODO:
            // Use a "Commit Point" variable to indicate whether the proposal's instructions have been executed. 
            // This will help prevent issues related to transaction failures or traps in the system.
            switch(proposal.proposalType) {
              case(#Newcomer) {
                let member = MemberHelper.createMember(members, Option.get(proposal.instruction, "Unknown"), proposal.createdBy, [#Volunteer]);
              };
              case(_) {

              };
            };
            return #ok(#ProposalAccepted);
          };
          case(#Rejected) {
            return #ok(#ProposalRefused)
          };
        };
      };
    };
  };

  public func isInstructionRequired(proposals : Proposals, proposalType : ProposalType): Bool {
    return proposalType == #DocumentManagement;
  };

  public func getNewcomerProposalRequest(proposals : Proposals, principal : Principal) : ?(Nat, Proposal) {
    let result : ?(Nat, Proposal) = Iter.filter(proposals.entries(), func(a : (Nat, Proposal)) : Bool { a.1.createdBy == principal and a.1.proposalType == #Newcomer; }).next();

    return result;
  };

  public func createNewProposal(proposals : Proposals, nextProposalId : Nat, proposalType : ProposalType, description : Text, createdBy : Principal, instruction : ?Text) : Proposal {
    // Create a new proposal
    let proposalId = nextProposalId;
    let newProposal: Proposal = {
        id = proposalId;
        createdBy = createdBy;
        proposalType = proposalType;
        description = description;
        status = #Open;
        instruction = instruction;
        votes = 0;
        voters = [];
    };

    // Store the proposal
    proposals.put(proposalId, newProposal);

    return newProposal;
  };
};