import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../models/user_profile_model.dart';
import 'registration_form_service.dart';

class UserFirestoreService {
  final RegistrationService _registrationService =
      GetIt.instance<RegistrationService>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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

  //* Send an email verification to the user.
  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print("Verification email sent to ${user.email}");
    } else {
      print("User is either not logged in or email is already verified.");
    }
  }

  //* Create user document in cloud firestore upon first time logging in.
  Future<void> createUserProfile() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot doc = await userDoc.get();
      if (!doc.exists) {
        UserProfileModel registrationProfile =
            _registrationService.getUserProfile();
        UserProfileModel userProfile = UserProfileModel(
          userId: user.uid,
          displayName: user.displayName ?? registrationProfile.displayName,
          email: user.email ?? registrationProfile.email,
          gender: registrationProfile.gender,
          phoneNumber: registrationProfile.phoneNumber,
          customPictureUrl: null,
          originalPictureUrl: user.photoURL,
          points: 0.0,
          targetPoints: 0.0,
          targetDate: null,
        );
        await userDoc.set(userProfile.toMap());
        print("User profile created with registration data for ${user.uid}");
      } else {
        print("User profile already exists for ${user.uid}");
      }
    } else {
      print("No user is currently logged in.");
    }
  }

  //* Fetch user fields in firestore
  Future<UserProfileModel?> getUserProfile() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        return UserProfileModel.fromMap(data ?? {});
      }
    }
    return null;
  }

  Future<void> updateUserProfileFields(
      String? userId, Map<String, dynamic> fields) async {
    if (userId == null || userId.isEmpty) {
      throw ArgumentError("Invalid user ID: cannot be null or empty.");
    }
    await _firestore.collection("users").doc(userId).update(fields);
  }

  //* Update user profile picture
  Future<void> updateUserProfilePicture(String userId, String imagePath) async {
    File file = File(imagePath);
    String storagePath =
        'profile_pictures/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
    TaskSnapshot uploadTask = await _storage.ref(storagePath).putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();

    await _firestore.collection('users').doc(userId).update({
      'customPictureUrl': downloadURL,
    });
  }

  //* Update user gender
  Future<void> updateUserGender(String gender) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'gender': gender,
      });
    }
  }

  //* Update user phone number
  Future<void> updateUserPhoneNumber(String phoneNumber) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'phoneNumber': phoneNumber,
      });
    }
  }

  //* Remove current user profile picture, restore to default.
  Future<void> removeCurrentUserPicture() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentSnapshot userSnapshot = await userDoc.get();
      String? customPictureUrl = userSnapshot['customPictureUrl'];

      if (customPictureUrl != null && customPictureUrl.isNotEmpty) {
        await _storage.refFromURL(customPictureUrl).delete();

        await userDoc.update({
          'customPictureUrl': null,
        });
      }
    }
  }

  //* Update target date and points in firestore
  Future<void> updateUserProfileTarget(String userId,
      {double? targetPoints, DateTime? targetDate}) async {
    if (targetDate != null && targetPoints == null) {
      throw Exception('Cannot set a target date without target points.');
    }

    Map<String, dynamic> updates = {};

    if (targetPoints != null && targetPoints != 0) {
      updates['targetPoints'] = targetPoints;
    }

    if (targetDate != null) {
      updates['targetDate'] = targetDate.toIso8601String();
    }

    if (updates.isNotEmpty) {
      DocumentReference userDoc = _firestore.collection('users').doc(userId);
      await userDoc.update(updates);
    }
  }

  //* Reset target date and points
  Future<void> resetTargets(String userId) async {
    Map<String, dynamic> updates = {
      'targetPoints': 0.0,
      'targetDate': null,
    };

    DocumentReference userDoc = _firestore.collection('users').doc(userId);
    await userDoc.update(updates);
  }
}
