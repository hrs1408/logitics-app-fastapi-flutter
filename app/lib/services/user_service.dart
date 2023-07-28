import 'package:app/resources/app_http.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<dynamic> getUsers(String token) async {
    var response = await http.get(
      Uri.parse('${AppHttp.baseUrl}/user'),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer $token"
      },
    );
    return response;
  }
}
