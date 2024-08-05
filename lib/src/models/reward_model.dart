import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  final String category;
  final String rewardID;
  final String rewardName;
  final String rewardDescription;
  final String rewardPicture;
  final String campus;
  final String vendorID;
  final String stallName;
  final double requiredPoint;
  final int rewardStock;
  final DateTime expiryDate;
  final DateTime createdAt;

  RewardModel(
      {required this.category,
      required this.rewardID,
      required this.rewardName,
      required this.rewardDescription,
      required this.rewardPicture,
      required this.campus,
      required this.vendorID,
      required this.stallName,
      required this.requiredPoint,
      required this.rewardStock,
      required this.expiryDate,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'rewardID': rewardID,
      'rewardName': rewardName,
      'description': rewardDescription,
      'rewardPicture': rewardPicture,
      'requiredPoint': requiredPoint,
      'rewardStock': rewardStock,
      'campus': campus,
      'vendorID': vendorID,
      'stallName': stallName,
      'expiryDate': expiryDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    DateTime parsedExpiryDate;
    if (map['expiryDate'] is String) {
      parsedExpiryDate = DateTime.parse(map['expiryDate']);
    } else if (map['expiryDate'] is Timestamp) {
      parsedExpiryDate = (map['expiryDate'] as Timestamp).toDate();
    } else {
      parsedExpiryDate = DateTime.now();
    }

    DateTime parsedCreatedAt;
    if (map['createdAt'] is Timestamp) {
      parsedCreatedAt = (map['createdAt'] as Timestamp).toDate();
    } else if (map['createdAt'] is String) {
      parsedCreatedAt = DateTime.parse(map['createdAt']);
    } else {
      parsedCreatedAt = DateTime.now();
    }

    return RewardModel(
      category: map['category'] ?? "",
      rewardID: map['rewardID'] ?? "",
      rewardName: map['rewardName'] ?? "",
      rewardDescription: map['rewardDescription'] ?? "",
      rewardPicture: map['rewardPicture'] ?? "",
      campus: map['campus'] ?? "",
      stallName: map['stallName'] ?? "",
      requiredPoint: (map['requiredPoint'] is int)
          ? (map['requiredPoint'] as int).toDouble()
          : map['requiredPoint'] ?? 0.00,
      rewardStock: map['rewardStock'] ?? 0,
      expiryDate: parsedExpiryDate,
      createdAt: parsedCreatedAt,
      vendorID: map['vendorID'] ?? "",
    );
  }
}
