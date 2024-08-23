import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user_profile_model.dart';
import 'firebase_services.dart';

class UserProfileService extends ChangeNotifier {
  final FirebaseServices _userService = GetIt.instance<FirebaseServices>();

  final ValueNotifier<UserProfileModel?> _userProfileNotifier =
      ValueNotifier<UserProfileModel?>(null);

  ValueNotifier<UserProfileModel?> get userProfileNotifier =>
      _userProfileNotifier;

  UserProfileModel? get userProfile => _userProfileNotifier.value;

  //* Getters for individual user profile fields
  String? get userId => _userProfileNotifier.value?.userId;
  String? get displayName => _userProfileNotifier.value?.displayName;
  String? get email => _userProfileNotifier.value?.email;
  String? get gender => _userProfileNotifier.value?.gender;
  String? get phoneNumber => _userProfileNotifier.value?.phoneNumber;
  String? get customPictureUrl => _userProfileNotifier.value?.customPictureUrl;
  String? get originalPictureUrl =>
      _userProfileNotifier.value?.originalPictureUrl;
  double? get points => _userProfileNotifier.value?.points;
  double? get targetPoints => _userProfileNotifier.value?.targetPoints;
  DateTime? get targetDate => _userProfileNotifier.value?.targetDate;

  Future<void> loadUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    UserProfileModel? profile = await _userService.getUserProfile();
    if (profile == null) {
      await _userService.createUserProfile();
      profile = await _userService.getUserProfile();
    }
    _userProfileNotifier.value = profile;
    notifyListeners();
  }

  //* Function to update user points in Firestore and locally
  Future<void> updateUserPoints(double newPoints) async {
    if (_userProfileNotifier.value != null) {
      UserProfileModel updatedProfile = _userProfileNotifier.value!;
      updatedProfile.points = newPoints;
      await _userService.updateUserProfileFields(
          updatedProfile.userId, {'points': newPoints});
      _userProfileNotifier.value = updatedProfile;
      await loadUserProfile();
    }
  }

  //* Function to update user points target
  Future<void> updateUserProfileTarget(
      double? targetPoints, DateTime? targetDate) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserProfileTarget(user.uid,
          targetPoints: targetPoints, targetDate: targetDate);
      await loadUserProfile();
    }
  }

  //* Function to update user gender
  Future<void> updateUserGender(String gender) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserGender(gender);
      await loadUserProfile();
    }
  }

  //* Function to update user phone number
  Future<void> updateUserPhoneNumber(String phoneNumber) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserPhoneNumber(phoneNumber);
      await loadUserProfile();
    }
  }

  //* Function to reset user points target
  Future<void> resetTargets() async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.resetTargets(user.uid);
      await loadUserProfile();
    }
  }

  //* Function to update user profile picture
  Future<void> updateUserProfilePicture(String imagePath) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserProfilePicture(user.uid, imagePath);
      await loadUserProfile();
    }
  }

  //* Function to remove user profile picture
  Future<void> removeCurrentUserPicture() async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.removeCurrentUserPicture();
      await loadUserProfile();
    }
  }
}
