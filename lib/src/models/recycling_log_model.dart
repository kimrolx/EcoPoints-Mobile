class RecyclingLog {
  final DateTime dateTime;
  final int bottlesRecycled;
  final int pointsGained;

  RecyclingLog(
      {required this.dateTime,
      required this.bottlesRecycled,
      required this.pointsGained});

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'bottlesRecycled': bottlesRecycled,
      'pointsGained': pointsGained,
    };
  }

  factory RecyclingLog.fromMap(Map<String, dynamic> map) {
    return RecyclingLog(
      dateTime: DateTime.parse(map['dateTime']),
      bottlesRecycled: map['bottlesRecycled'],
      pointsGained: map['pointsGained'],
    );
  }
}
