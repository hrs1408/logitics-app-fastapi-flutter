import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientPanel extends StatelessWidget {
  const ClientPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/home');
        },
        child: const Text('Go back!'),
      ),
    ));
  }
}
