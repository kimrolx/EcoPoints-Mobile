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
      'dateTime': dateTime.toIso8601String(),
      'bottlesRecycled': bottlesRecycled,
      'pointsGained': pointsGained,
      'oldPoints': oldPoints,
      'refId': refId,
    };
  }

  factory RecyclingLogModel.fromMap(Map<String, dynamic> map) {
    return RecyclingLogModel(
      dateTime:
          DateTime.parse(map['dateTime'] ?? DateTime.now().toIso8601String()),
      bottlesRecycled: map['bottlesRecycled'] ?? 0,
      pointsGained: (map['pointsGained'] is int)
          ? (map['pointsGained'] as int).toDouble()
          : map['pointsGained'] ?? 0.00,
      oldPoints: (map['oldPoints'] is int)
          ? (map['oldPoints'] as int).toDouble()
          : map['oldPoints'],
      refId: map['refId'] ?? '',
    );
  }
}
