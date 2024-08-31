import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/reward_model.dart';

class RewardsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<RewardModel>> getNewRewards() {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print("Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      //* Sorting logic: move 'Out of Stock' items to the bottom
      rewards.sort((a, b) {
        //* Check if either of the rewards is out of stock
        if (a.rewardStock > 0 && b.rewardStock > 0) {
          //* Both are in stock, keep the order by createdAt
          return 0;
        } else if (a.rewardStock > 0) {
          //* a is in stock, b is out of stock, a comes first
          return -1;
        } else if (b.rewardStock > 0) {
          //* b is in stock, a is out of stock, b comes first
          return 1;
        } else {
          //* Both are out of stock, keep the order by createdAt
          return 0;
        }
      });

      return rewards;
    });
  }

  Future<void> updateRewardStock(String rewardId, int amount) async {
    return _firestore
        .collection('rewards')
        .doc(rewardId)
        .update({'rewardStock': FieldValue.increment(-amount)});
  }
}
