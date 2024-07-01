class UserProfileModel {
  final String userId;
  final String? displayName;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  double points;
  double? targetPoints;
  DateTime? targetDate;

  UserProfileModel({
    required this.userId,
    this.displayName,
    this.email,
    this.gender,
    this.phoneNumber,
    required this.points,
    this.targetPoints,
    this.targetDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
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
