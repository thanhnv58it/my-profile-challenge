import 'dart:convert';

import 'package:my_profile/config/storage.dart';
import 'package:my_profile/services/model/app_user.dart';
import 'package:my_profile/services/repositories/abstract/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final secureStorage = Storage().secureStorage;
  static const userDataKey = 'kUserData';
  @override
  Future<AppUser> saveUserData({
    required String email,
    required String password,
  }) async {
    final user = AppUser(email, password);
    await secureStorage.write(key: userDataKey, value: jsonEncode(user));
    return user;
  }

  @override
  Future<AppUser?> getSavedUserData() async {
    final json = await secureStorage.read(key: userDataKey);
    if (json != null) {
      return AppUser.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }

  @override
  void deleteUserData() {
    secureStorage.delete(key: userDataKey);
  }
}
