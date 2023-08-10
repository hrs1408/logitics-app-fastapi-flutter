import 'dart:convert';
import 'package:http/http.dart' as http;

import '../resources/app_http.dart';

class AuthService {
  Future<dynamic> login(String email, String password) async {
    var response = await http.post(
      Uri.parse('${AppHttp.baseUrl}/auth/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

  Future<dynamic> getMe(String token) async {
    var response =
        await http.get(Uri.parse('${AppHttp.baseUrl}/auth/me'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      "ngrok-skip-browser-warning": "true",
    });
    return response;
  }
}
