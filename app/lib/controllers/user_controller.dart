import 'package:app/services/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/user_data.dart';
import '../models/user.dart';

class UserController extends GetxController {
  Rx<UserDataSource> userDataSource = UserDataSource(users: []).obs;
  RxList<User> users = List<User>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('access_token');
      if (token == null) {
        Get.offAllNamed('/login');
      }
      var response = await UserService().getUsers(token!);
      if (response != null) {
        users.assignAll(listUserFromJson(response.body));
      }
    } finally {
      isLoading.value = false;
      userDataSource.value = UserDataSource(users: users);
    }
  }
}
