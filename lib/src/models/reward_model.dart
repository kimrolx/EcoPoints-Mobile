import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  final String rewardID;
  final String rewardName;
  final String rewardDescription;
  final String rewardPicture;
  final double requiredPoint;
  final int rewardStock;
  final DateTime expiryDate;
  final DateTime createdAt;

  RewardModel(
      {required this.rewardID,
      required this.rewardName,
      required this.rewardDescription,
      required this.rewardPicture,
      required this.requiredPoint,
      required this.rewardStock,
      required this.expiryDate,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'rewardID': rewardID,
      'rewardName': rewardName,
      'description': rewardDescription,
      'rewardPicture': rewardPicture,
      'requiredPoint': requiredPoint,
      'rewardStock': rewardStock,
      'expiryDate': expiryDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    return RewardModel(
      rewardID: map['rewardID'] ?? "",
      rewardName: map['rewardName'] ?? "",
      rewardDescription: map['rewardDescription'] ?? "",
      rewardPicture: map['rewardPicture'] ?? "",
      requiredPoint: (map['requiredPoint'] is int)
          ? (map['requiredPoint'] as int).toDouble()
          : map['requiredPoint'] ?? 0.00,
      rewardStock: map['rewardStock'] ?? 0,
      expiryDate:
          DateTime.parse(map['expiryDate'] ?? DateTime.now().toIso8601String()),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
