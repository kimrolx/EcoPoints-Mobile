import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../models/transaction_model.dart';
import 'user_profile_service.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserProfileService _userProfileService =
      GetIt.instance<UserProfileService>();

  //* Add transaction to Firestore
  Future<void> addTransaction(TransactionModel transactionLog) async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) {
      print("Oops! You are not authorized.");
      return;
    }

    DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

    try {
      await _firestore.runTransaction((fsTransaction) async {
        DocumentSnapshot userSnapshot = await fsTransaction.get(userDoc);

        if (!userSnapshot.exists) {
          throw Exception("User document does not exist!");
        }

        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        double currentPoints = (userData['points'] is int)
            ? (userData['points'] as int).toDouble()
            : userData['points'] as double;

        transactionLog.oldPoints = currentPoints;

        double newPoints = currentPoints - transactionLog.totalPrice;

        DocumentReference transRef =
            _firestore.collection('transactions').doc();
        transactionLog.transactionId = transRef.id;

        Map<String, dynamic> transactionData = transactionLog.toMap();
        transactionData['userId'] = user.uid;
        transactionData['timeCreated'] = FieldValue.serverTimestamp();

        fsTransaction.set(transRef, transactionData);

        fsTransaction.update(userDoc, {'points': newPoints});

        print(
            "From TransactionService: Transaction added successfully for user: ${user.uid} --- old balance: ${userData['points']} --- new balance: $newPoints");
      });

      await _userProfileService.loadUserProfile();
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }

  //* Get real time transactions from Firestore
  Stream<List<TransactionModel>> getUserTransactions() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return _firestore
          .collection('transactions')
          .where('userId', isEqualTo: user.uid)
          .orderBy('timeCreated', descending: true)
          .snapshots()
          .map((snapshot) {
        print(
            "From getUserTransactions: Transaction snapshot received: ${snapshot.docs.length} documents for user ${user.uid}");
        return snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data()))
            .toList();
      });
    } else {
      print("No user is currently logged in.");
    }
    return Stream.value([]);
  }
}
