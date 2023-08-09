import 'package:app/screens/dashboard/dash_board_screen.dart';
import 'package:app/screens/user_manager/user_manager_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TabControllerE extends GetxController {
  RxInt currentIndex = 0.obs;
  List<StatelessWidget> tabs = [const DashboardScreen(), UserManagerScreen()];

  void changeTabIndex(int index) {
    switch (index) {
      case 0:
        currentIndex.value = index;
        break;
      case 1:
        currentIndex.value = index;
        break;
      default:
        currentIndex.value = index;
        break;
    }
  }
}
