import 'package:app/resources/screen_responsive.dart';
import 'package:app/screens/dashboard/dash_board_screen.dart';
import 'package:app/screens/user_manager/user_manager_screen.dart';
import 'package:app/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ScreenResponsive.isDesktop(context))Expanded(
              flex: 2,
              child: SideMenu(onTap: onItemTapped),
            ),
            Expanded(
              flex: 10,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0XFF282E45),
                  child: Obx(() => switchScreen(selectedIndex.value))),
            )
          ],
        ),
      ),
    );
  }

  switchScreen(int value) {
    switch (value) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const UserManagerScreen();
      default:
        return const DashboardScreen();
    }
  }
}
