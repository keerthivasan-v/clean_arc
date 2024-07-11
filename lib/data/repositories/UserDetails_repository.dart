import 'dart:convert';

import 'package:clean_arc/data/models/ListUser_model.dart';
import 'package:clean_arc/data/services/UserDetails_service.dart';

class UserDetailsRepository {
  final UserDetailsService service;

  UserDetailsRepository(this.service);

  Future<ListUserData> fetchUserDetails(dynamic param) async {
    final response = await service.fetchUser(param);
    final res = jsonDecode(response);
    Map<String, dynamic> body = res['data'];
    ListUserData users = ListUserData.fromJson(body);
    return users;
  }
}
