class UserProfileModel {
  String? userId;
  String? displayName;
  String? email;
  String? gender;
  String? phoneNumber;
  double points;

  UserProfileModel(
      {required this.userId,
      this.displayName,
      this.email,
      this.gender,
      this.phoneNumber,
      required this.points});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'points': points,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      userId: map['userId'],
      displayName: map['displayName'],
      email: map['email'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      points: (map['points'] is int)
          ? (map['points'] as int).toDouble()
          : map['points'] as double,
    );
  }
}
