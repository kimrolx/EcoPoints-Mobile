import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/user_profile_model.dart';
import 'user_firestore_service.dart';

class UserProfileService extends ChangeNotifier {
  final UserFirestoreService _userService =
      GetIt.instance<UserFirestoreService>();

  final ValueNotifier<UserProfileModel?> _userProfileNotifier =
      ValueNotifier<UserProfileModel?>(null);

  ValueNotifier<UserProfileModel?> get userProfileNotifier =>
      _userProfileNotifier;

  UserProfileModel? get userProfile => _userProfileNotifier.value;

  Future<void> loadUserProfile() async {
    UserProfileModel? profile = await _userService.getUserProfile();
    if (profile == null) {
      await _userService.createUserProfile();
      profile = await _userService.getUserProfile();
    }
    _userProfileNotifier.value = profile;
    notifyListeners();
  }

  Future<void> updateUserProfileTarget(
      double? targetPoints, DateTime? targetDate) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserProfileTarget(user.uid,
          targetPoints: targetPoints, targetDate: targetDate);
      await loadUserProfile();
    }
  }

  Future<void> resetTargets() async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.resetTargets(user.uid);
      await loadUserProfile();
    }
  }

  Future<void> updateUserProfilePicture(String imagePath) async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.updateUserProfilePicture(user.uid, imagePath);
      await loadUserProfile();
    }
  }

  Future<void> removeCurrentUserPicture() async {
    User? user = _userService.getCurrentUser();
    if (user != null) {
      await _userService.removeCurrentUserPicture();
      await loadUserProfile();
    }
  }
}