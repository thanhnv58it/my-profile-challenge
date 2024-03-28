import 'package:get_it/get_it.dart';

import 'package:my_profile/data/repositories/abstract/user_repository.dart';
import 'package:my_profile/data/repositories/user_repository_impl.dart';

final sl = GetIt.instance;

//Service locator description
void init() {
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );
}
