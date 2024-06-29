class UserProfile {
  String? displayName;
  String? email;
  String? gender;
  String? phoneNumber;
  double? points;

  UserProfile(
      {this.displayName,
      this.email,
      this.gender,
      this.phoneNumber,
      this.points});

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'points': points,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      displayName: map['displayName'],
      email: map['email'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      points: map['points'],
    );
  }
}
