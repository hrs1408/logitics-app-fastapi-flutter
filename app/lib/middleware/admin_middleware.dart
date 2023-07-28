import 'package:app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMiddleware extends GetMiddleware {
  final AuthController authController = Get.put(AuthController());

  @override
  RouteSettings? redirect(String? route) {
    if (authController.userLogin.value.workPositionId == 1 &&
        authController.userLogin.value.id != 0) {
      return null;
    } else {
      return const RouteSettings(name: '/login');
    }
  }
}
