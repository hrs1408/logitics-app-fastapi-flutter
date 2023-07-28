import 'dart:convert';
import 'package:app/models/user_information.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User> userLogin = User(
    id: 0,
    email: '',
    userRole: '',
    workPositionId: 0,
    branchId: 0,
    vehicleId: 0,
    isActive: false,
    userInformation: UserInformation(
      id: 0,
      fullName: '',
      phoneNumber: '',
      dateOfBirth: '',
      identityCardCode: '',
      userId: 0,
    ),
  ).obs;
  RxInt workPositionId = 0.obs;
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    getUserLogin();
    super.onInit();
  }

  void login(String email, String password) async {
    try {
      isLoading.value = true;
      var response = await AuthService().login(email, password);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data['data']['access_token'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', token);
        var getMeResponse = await AuthService().getMe(token);
        userLogin.value =
            User.userFromJson(jsonDecode(getMeResponse.body)['data']);
        workPositionId = userLogin.value.workPositionId.obs;
        isLogin.value = true;
        switch (userLogin.value.workPositionId) {
          case 1:
            Get.offAllNamed('/admin');
            break;
          case 2:
            Get.offAllNamed('/manager_panel');
            break;
          case 3:
            Get.offAllNamed('/warehouse_panel');
            break;
          case 4:
            Get.offAllNamed('/driver_panel');
            break;
          case 5:
            Get.offAllNamed('/delivery_panel');
            break;
          case 6:
            Get.offAllNamed('/customer_panel');
            break;
          default:
            Get.offAllNamed('/login');
            break;
        }
      } else {
        if (response.statusCode == 422) {
          Get.snackbar(
            'Login Failed',
            json.decode(response.body)['data'][0]['msg'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white70,
            margin: const EdgeInsets.all(20),
          );
        } else if (response.statusCode == 400) {
          Get.snackbar(
            'Login Failed',
            json.decode(response.body)['data'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white70,
            margin: const EdgeInsets.all(20),
          );
        } else {
          Get.snackbar(
            'Login Failed',
            'Something went wrong',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white70,
            margin: const EdgeInsets.all(20),
          );
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void getUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    var response = await AuthService().getMe(token!);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      userLogin.value = User.userFromJson(data['data']);
      workPositionId = userLogin.value.workPositionId.obs;
    } else {
      Get.snackbar(
        'Get Me Failed',
        'Something went wrong',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white70,
        margin: const EdgeInsets.all(20),
      );
    }
  }
}
