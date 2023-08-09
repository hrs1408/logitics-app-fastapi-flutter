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

  Future<dynamic> getUser(String token, int id) async {
    var response = await http.get(
      Uri.parse('${AppHttp.baseUrl}/user/$id'),
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
    return response;
  }

  Future<dynamic> deleteUser(String token, int id) async {
    var response = await http.delete(Uri.parse('${AppHttp.baseUrl}/user/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });
    return response;
  }

  Future<dynamic> deActiveUser(String token, int id) async {
    var response = await http
        .put(Uri.parse('${AppHttp.baseUrl}/user/de-active/$id'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }

  Future<dynamic> activeUser(String token, int id) async {
    var response = await http
        .put(Uri.parse('${AppHttp.baseUrl}/user/active/$id'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    return response;
  }
}
