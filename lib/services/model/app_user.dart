import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String username;
  final String password;

  AppUser(this.username, this.password);

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
