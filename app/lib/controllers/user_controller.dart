import 'dart:convert';

import 'package:app/models/dto/user_create.dart';
import 'package:app/services/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/user_data.dart';
import '../models/user.dart';

class UserController extends GetxController {
  Rx<UserDataSource> userDataSource = UserDataSource(users: []).obs;
  RxList<User> users = List<User>.empty(growable: true).obs;
  RxBool isLoading = false.obs;
  RxInt selectedId = 0.obs;

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

  void createUser(UserCreate userCreate) async {
    print(jsonEncode(userCreate));
    try{
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('access_token');
      if (token == null) {
        Get.offAllNamed('/login');
      }
      var response = await UserService().createNewUser(token!, userCreate);
      if (response.statusCode == 200) {
        getUsers();
        Get.snackbar('Success', 'User created successfully');
      } else {
        Get.snackbar('Error', response.statusCode);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
