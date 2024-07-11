import 'package:clean_arc/data/repositories/ListUser_repository.dart';
import 'package:clean_arc/data/repositories/UserDetails_repository.dart';
import 'package:clean_arc/data/services/ListUser_service.dart';
import 'package:clean_arc/data/services/UserDetails_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerLazySingleton<ListUserRepository>(
      () => ListUserRepository(ListUserService()));
  getIt.registerLazySingleton<UserDetailsRepository>(
      () => UserDetailsRepository(UserDetailsService()));
}
