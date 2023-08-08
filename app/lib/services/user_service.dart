import 'dart:convert';

import 'package:app/resources/app_http.dart';
import 'package:http/http.dart' as http;

import '../models/dto/user_create.dart';

class UserService {
  Future<dynamic> getUsers(String token) async {
    var response = await http.get(
      Uri.parse('${AppHttp.baseUrl}/user'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }

  Future<dynamic> createNewUser(String token, UserCreate user) async {
    var body = jsonEncode(user);
    var response = await http.post(Uri.parse('${AppHttp.baseUrl}/user/create'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: body);
    print(response.body);
    return response;
  }
}
