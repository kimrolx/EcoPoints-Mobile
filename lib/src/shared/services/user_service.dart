import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_profile_model.dart';

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getCurrentUserPhotoURL() {
    return _firebaseAuth.currentUser?.photoURL;
  }

  String? getCurrentUserName() {
    return _firebaseAuth.currentUser?.displayName;
  }

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  //* Create user document in cloud firestore upon first time logging in.
  Future<void> createUserProfile() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot doc = await userDoc.get();
      if (!doc.exists) {
        UserProfileModel userProfile = UserProfileModel(
          userId: user.uid,
          displayName: user.displayName,
          email: user.email,
          gender: '',
          phoneNumber: '',
          points: 0.0,
        );
        await userDoc.set(userProfile.toMap());
        await userDoc.collection('recyclingLog').doc('logId').set({});
        // await userDoc.collection('transactionHistories').doc('init').set({});
        print('User profile created for ${user.uid}');
      } else {
        print('User profile already exists for ${user.uid}');
      }
    } else {
      print('No user is currently logged in.');
    }
  }

  Future<void> updateUserProfile(UserProfileModel userProfile) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(userProfile.toMap());
    }
  }

  //* Fetch user fields in firestore
  Future<UserProfileModel?> getUserProfile() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserProfileModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }
}
