import 'package:http/http.dart' as http;

class UserDetailsService {
  final baseUrl = "https://reqres.in/api/users/";

  Future<String> fetchUser(String UserID) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$UserID"));
      return response.body;
    } catch (e) {
      return e.toString();
    }
  }
}
