import 'dart:convert';

import 'package:my_profile/data/model/app_user.dart';
import 'package:my_profile/data/repositories/abstract/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepositoryImpl extends UserRepository {
  final secureStorage = const FlutterSecureStorage();
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
