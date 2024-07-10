class RewardModel {
  final String name;
  final String description;
  final double requiredPoints;
  final int stock;
  final DateTime expiryDate;

  RewardModel({
    required this.name,
    required this.description,
    required this.requiredPoints,
    required this.stock,
    required this.expiryDate,
  });
}
