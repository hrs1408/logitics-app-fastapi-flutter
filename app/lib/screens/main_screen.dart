import 'package:app/controllers/tab_controller.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:app/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerControllerE drawerControllerE = Get.put(DrawerControllerE());
    TabControllerE tabController = Get.put(TabControllerE());

    return Scaffold(
      key: drawerControllerE.scaffoldKey,
      drawer: SideMenu(onTap: tabController.changeTabIndex, tabs: []),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ScreenResponsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: SideMenu(onTap: tabController.changeTabIndex, tabs: []),
              ),
            Expanded(
              flex: 10,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: const Color(0XFF282E45),
                child: Obx(
                    () => tabController.tabs[tabController.currentIndex.value]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
