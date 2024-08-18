import 'package:cloud_firestore/cloud_firestore.dart';

class RecyclingLogModel {
  final DateTime dateTime;
  final int bottlesRecycled;
  final double pointsGained;
  double oldPoints;
  String? refId;

  RecyclingLogModel({
    required this.dateTime,
    required this.bottlesRecycled,
    required this.pointsGained,
    this.oldPoints = 0.00,
    this.refId,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateTime': Timestamp.fromDate(dateTime),
      'bottlesRecycled': bottlesRecycled,
      'pointsGained': pointsGained,
      'oldPoints': oldPoints,
      'refId': refId,
    };
  }

  factory RecyclingLogModel.fromMap(Map<String, dynamic> map) {
    DateTime parsedDateTime;
    if (map['dateTime'] is Timestamp) {
      parsedDateTime = (map['dateTime'] as Timestamp).toDate();
    } else if (map['dateTime'] is String) {
      parsedDateTime = DateTime.parse(map['dateTime']);
    } else {
      parsedDateTime = DateTime.now();
    }

    return RecyclingLogModel(
      dateTime: parsedDateTime,
      bottlesRecycled: map['bottlesRecycled'] ?? 0,
      pointsGained: (map['pointsGained'] is int)
          ? (map['pointsGained'] as int).toDouble()
          : map['pointsGained'] as double,
      oldPoints: (map['oldPoints'] is int)
          ? (map['oldPoints'] as int).toDouble()
          : map['oldPoints'] as double,
      refId: map['refId'] ?? '',
    );
  }
}
