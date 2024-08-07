import '../../models/user_profile_model.dart';

class RegistrationService {
  UserProfileModel userProfile = UserProfileModel();

  void updateName(String firstName, String lastName) {
    userProfile.updateDisplayName(firstName: firstName, lastName: lastName);
  }

  void updateGender(String gender) {
    userProfile.updateGender(gender);
  }

  void updateEmail(String email) {
    userProfile.updateEmail(email);
  }

  UserProfileModel getUserProfile() {
    return userProfile;
  }
}
