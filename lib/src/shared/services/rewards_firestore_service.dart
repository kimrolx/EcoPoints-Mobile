import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/reward_model.dart';

class RewardsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<RewardModel>> getRewards() {
    return _firestore
        .collection('rewards')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      print("Rewards data snapshot received: ${snapshot.docs.length}");
      return snapshot.docs
          .map((doc) => RewardModel.fromMap(doc.data()))
          .toList();
    });
  }
}
