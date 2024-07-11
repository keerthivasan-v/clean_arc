import 'package:clean_arc/data/models/ListUser_model.dart';
import 'package:clean_arc/data/services/ListUser_service.dart';

class ListUserRepository {
  final ListUserService service;

  ListUserRepository(this.service);

  Future<ListUser> fetchUser(int page) async {
    final response = await service.fetchUser(page);

    return userFromJson(response);
  }
}
