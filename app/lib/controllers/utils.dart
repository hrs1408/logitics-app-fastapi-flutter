import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    if (token == null) {
      Get.offAllNamed('/login');
    }
    return token!;
  }
}
