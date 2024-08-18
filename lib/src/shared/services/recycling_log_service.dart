import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../models/recycling_log_model.dart';
import 'user_profile_service.dart';

class RecyclingLogService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();
  final CollectionReference _recyclingLogsCollection =
      FirebaseFirestore.instance.collection('recyclingLogs');

  Future<void> addRecyclingLog(RecyclingLogModel log) async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      CollectionReference logsCollection = userDoc.collection('recyclingLogs');

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot userSnapshot = await transaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception("User document does not exist!");
        }

        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        double currentPoints = (userData['points'] is int)
            ? (userData['points'] as int).toDouble()
            : (userData['points'] as double);

        log.oldPoints = currentPoints;

        double newPoints = currentPoints + log.pointsGained;
        transaction.update(userDoc, {'points': newPoints});

        DocumentReference newLogRef = logsCollection.doc();
        log.refId = newLogRef.id;
        transaction.set(newLogRef, log.toMap());
      });
      await _userProfileService.loadUserProfile();
    }
  }

  //* Get real time recycling logs from firestore
  Stream<List<RecyclingLogModel>> getRecyclingLogs() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('recyclingLogs')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .map((snapshot) {
        print(
            "Recycling logs snapshot received: ${snapshot.docs.length} documents for user ${user.uid}");
        return snapshot.docs
            .map((doc) => RecyclingLogModel.fromMap(doc.data()))
            .toList();
      });
    } else {
      print("No user is currently logged in.");
    }
    return Stream.value([]);
  }

  Future<void> refreshRecyclingLogs() async {
    //TODO: fetch latest data and store in local cache???
    await _recyclingLogsCollection.get();
  }
}
