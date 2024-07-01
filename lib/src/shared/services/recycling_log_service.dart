import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/recycling_log_model.dart';

class RecyclingLogService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            : userData['points'] as double;

        log.oldPoints = currentPoints;

        double newPoints = currentPoints + log.pointsGained;
        transaction.update(userDoc, {'points': newPoints});

        DocumentReference newLogRef = logsCollection.doc();
        log.refId = newLogRef.id;
        transaction.set(newLogRef, log.toMap());
      });
    }
  }

  //* Get real time recycling logs from firestore
  Stream<List<RecyclingLogModel>> getRecyclingLogs() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      print("Listening to recycling logs for user: ${user.uid}");
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('recyclingLogs')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .map((snapshot) {
        print(
            "Recycling logs snapshot received: ${snapshot.docs.length} documents");
        return snapshot.docs
            .map((doc) => RecyclingLogModel.fromMap(doc.data()))
            .toList();
      });
    } else {
      print("No user is currently logged in.");
    }
    return Stream.value([]);
  }
}
