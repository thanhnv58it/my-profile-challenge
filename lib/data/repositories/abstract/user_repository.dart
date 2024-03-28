import 'package:my_profile/data/model/app_user.dart';

abstract class UserRepository {
  /// Sign in with [email] and [password] and return
  /// user data as [AppUser]
  Future<AppUser> saveUserData({
    required String email,
    required String password,
  });

  Future<AppUser?> getSavedUserData();

  void deleteUserData();
}
