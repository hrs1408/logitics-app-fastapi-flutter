import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackBarLight(String title, String message) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    margin: const EdgeInsets.all(10),
  );
}
