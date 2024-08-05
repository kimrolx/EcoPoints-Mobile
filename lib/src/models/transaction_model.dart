import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'reward_model.dart';

class TransactionModel {
  final RewardModel reward;
  final int quantity;
  final double totalPrice;
  double oldPoints;
  final DateTime timeCreated;
  final String referenceId;
  String? transactionId;
  final String userId;
  final String userName;
  final bool isClaimed;

  TransactionModel({
    required this.reward,
    this.quantity = 1,
    required this.totalPrice,
    this.oldPoints = 0.00,
    required this.timeCreated,
    required this.referenceId,
    this.userId = '',
    this.transactionId,
    required this.userName,
    this.isClaimed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'reward': reward.toMap(),
      'totalAmount': quantity,
      'totalPrice': totalPrice,
      'oldPoints': oldPoints,
      'timeCreated': Timestamp.fromDate(timeCreated),
      'referenceId': referenceId,
      'transactionId': transactionId,
      'userId': userId,
      'userName': userName,
      'isClaimed': isClaimed,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    DateTime parsedTimeCreated;
    if (map['timeCreated'] is Timestamp) {
      parsedTimeCreated = (map['timeCreated'] as Timestamp).toDate();
    } else if (map['timeCreated'] is String) {
      parsedTimeCreated = DateTime.parse(map['timeCreated']);
    } else {
      parsedTimeCreated = DateTime.now();
    }

    return TransactionModel(
      reward: RewardModel.fromMap(map['reward']),
      quantity: map['totalAmount'] ?? 1,
      totalPrice: (map['totalPrice'] is int)
          ? (map['totalPrice'] as int).toDouble()
          : map['totalPrice'] ?? 0.00,
      oldPoints: (map['oldPoints'] is int)
          ? (map['oldPoints'] as int).toDouble()
          : map['oldPoints'],
      timeCreated: parsedTimeCreated,
      referenceId: map['referenceId'] ?? '',
      transactionId: map['transactionId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      isClaimed: map['isClaimed'] ?? false,
    );
  }
}

class ReferenceIdGenerator {
  static String generateReferenceId() {
    final Random random = Random();

    String getRandomLetter(bool isLowerCase) {
      int baseCharCode = isLowerCase ? 97 : 65;
      return String.fromCharCode(baseCharCode + random.nextInt(26));
    }

    String fourDigitNumber = random.nextInt(10000).toString().padLeft(4, '0');

    String referenceId =
        "EP${getRandomLetter(true)}${getRandomLetter(false)}$fourDigitNumber${getRandomLetter(true)}";

    return referenceId;
  }
}
