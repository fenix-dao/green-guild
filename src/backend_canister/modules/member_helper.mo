import Iter "mo:base/Iter";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "../types";

module {
  public type Member = Types.Member;
  public type Members = Types.Members;
  public type MemberRole = Types.MemberRole;

  public func getMemberNames(members : Members) : [Text] {
    let entries = members.entries();
    let memberIter : Iter.Iter<Text> = {
      next = func () : ?Text {
        switch (entries.next()) {
          case (?(_, member)) {
            return ?member.name;
          };
          case null { return null; };
        };
      };
    };

    return Iter.toArray<Text>(memberIter);
  };

  public func createMember(members : Members, name : Text, memberPrincipal : Principal, roles : [MemberRole]) : Member {
    let member : Member = {
      name = name;
      roles = roles;
    };

    members.put(memberPrincipal, member);

    return member;
  };
};