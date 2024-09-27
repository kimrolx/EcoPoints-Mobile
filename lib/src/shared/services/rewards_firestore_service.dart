import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/reward_model.dart';

class RewardsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* Helper function to sort rewards by stock
  List<RewardModel> sortRewardsByStock(List<RewardModel> rewards) {
    rewards.sort((a, b) {
      if (a.rewardStock > 0 && b.rewardStock > 0) {
        return 0; //* Both in stock, no reordering needed
      } else if (a.rewardStock > 0) {
        return -1; //* a in stock, b out of stock, a comes first
      } else if (b.rewardStock > 0) {
        return 1; //* b in stock, a out of stock, b comes first
      } else {
        return 0; //* Both out of stock, no reordering needed
      }
    });
    return rewards;
  }

  Stream<List<RewardModel>> getNewRewards({int limit = 10}) {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      print("Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      return sortRewardsByStock(rewards);
    });
  }

  Stream<List<RewardModel>> getFoodRewards() {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .where('category', isEqualTo: 'Food')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print("Food Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      return sortRewardsByStock(rewards);
    });
  }

  Stream<List<RewardModel>> getSupplyRewards() {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .where('category', isEqualTo: 'School Supply')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print("Supply Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      return sortRewardsByStock(rewards);
    });
  }

  Stream<List<RewardModel>> getEventRewards() {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .where('category', isEqualTo: 'Event Ticket')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print("Events Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      return sortRewardsByStock(rewards);
    });
  }

  Stream<List<RewardModel>> getMostClaimedRewards({int limit = 15}) {
    return _firestore
        .collection('rewards')
        .where('status', isEqualTo: 'Approved')
        .orderBy('timesClaimed', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      print(
          "Most Claimed Rewards data snapshot received: ${snapshot.docs.length}");
      List<RewardModel> rewards =
          snapshot.docs.map((doc) => RewardModel.fromMap(doc.data())).toList();

      return sortRewardsByStock(rewards);
    });
  }

  Future<void> updateRewardStock(String rewardId, int amount) async {
    return _firestore
        .collection('rewards')
        .doc(rewardId)
        .update({'rewardStock': FieldValue.increment(-amount)});
  }

  Future<void> updateTimesClaimed(String rewardId, int amount) async {
    return _firestore
        .collection('rewards')
        .doc(rewardId)
        .update({'timesClaimed': FieldValue.increment(amount)});
  }
}
