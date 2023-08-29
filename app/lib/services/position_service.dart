import 'dart:convert';

import 'package:app/resources/app_http.dart';
import 'package:http/http.dart' as http;

class PositionService {
  Future<dynamic> getPositions(String token) async {
    var response = await http.get(
      Uri.parse('${AppHttp.baseUrl}/position'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true",
      },
    );
    return response;
  }

  Future<dynamic> createPosition(String token, String positionName) async {
    var body = jsonEncode({"position_name": positionName});
    var response =
        await http.post(Uri.parse('${AppHttp.baseUrl}/position/create'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: body);
    return response;
  }
}
