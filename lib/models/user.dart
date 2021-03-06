class User {
  // Don't need id. Autogenerated from the backend (?)
  final String id;
  String name;
  String email;
  String phoneNumber;

  // DateTime createdOnTimestamp;
  String password;
  int roleCode;
  int secondaryRole;
  String city;
  String requestText;
  String aboutMe;
  String clusterId;
  bool matched;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    // this.createdOnTimestamp,
    this.password = "password",
    this.roleCode,
    this.secondaryRole = 0,
    this.city = "San Francisco",
    this.requestText,
    this.aboutMe,
    this.clusterId = "",
    this.matched = false,
  });

  bool isNeeder() {
    return roleCode == 1;
  }

  bool isCaretaker() {
    return roleCode == 2;
  }

  bool isAdmin() {
    return roleCode == 3;
  }

  bool isMatched() {
    return matched;
  }
}
