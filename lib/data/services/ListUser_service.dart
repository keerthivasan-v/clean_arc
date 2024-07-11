import 'package:http/http.dart' as http;

class ListUserService {
  final baseUrl = "https://reqres.in/api/users";

  Future<String> fetchUser(int page) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl?page=$page"));
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}
