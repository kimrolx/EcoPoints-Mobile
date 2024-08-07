class UserProfileModel {
  String? userId;
  String? displayName;
  String? email;
  String? gender;
  String? phoneNumber;
  final String? customPictureUrl;
  final String? originalPictureUrl;
  double? points;
  double? targetPoints;
  DateTime? targetDate;

  UserProfileModel({
    this.userId,
    this.displayName,
    this.email,
    this.gender,
    this.phoneNumber,
    this.customPictureUrl,
    this.originalPictureUrl,
    this.points,
    this.targetPoints,
    this.targetDate,
  });

  void updateDisplayName({String? firstName, String? lastName}) {
    if (firstName != null && lastName != null) {
      String capitalizedFirstName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
      String capitalizedLastName =
          lastName[0].toUpperCase() + lastName.substring(1).toLowerCase();
      displayName = "$capitalizedFirstName $capitalizedLastName";
      print("From UserProfileModel - Updated Display Name: $displayName");
    } else {
      displayName = (firstName != null
              ? firstName[0].toUpperCase() +
                  firstName.substring(1).toLowerCase()
              : null) ??
          (lastName != null
              ? lastName[0].toUpperCase() + lastName.substring(1).toLowerCase()
              : null);
    }
  }

  void updateEmail(String email) {
    this.email = email;
    print("From UserProfileModel - Updated Email: $email");
  }

  void updateGender(String gender) {
    this.gender = gender;
    print("From UserProfileModel - Updated Gender: $gender");
  }

  void reset() {
    userId = null;
    displayName = null;
    email = null;
    gender = null;
    phoneNumber = null;
    points = null;
    targetPoints = null;
    targetDate = null;
    print("UserProfileModel has been reset");
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'photoUrl': customPictureUrl,
      'originalPictureUrl': originalPictureUrl,
      'points': points,
      'targetPoints': targetPoints,
      'targetDate': targetDate?.toIso8601String(),
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      userId: map['userId'],
      displayName: map['displayName'],
      email: map['email'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      customPictureUrl: map['customPictureUrl'],
      originalPictureUrl: map['originalPictureUrl'],
      points: (map['points'] is int)
          ? (map['points'] as int).toDouble()
          : map['points'] as double,
      targetPoints: map['targetPoints'] != null
          ? (map['targetPoints'] is int)
              ? (map['targetPoints'] as int).toDouble()
              : map['targetPoints'] as double
          : map['points'] as double,
      targetDate:
          map['targetDate'] != null ? DateTime.parse(map['targetDate']) : null,
    );
  }
}
