import 'package:app/controllers/auth_controller.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  final Function onTap;
  final List tabs;

  const SideMenu({super.key, required this.onTap, required this.tabs});

  void handleLogout() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('access_token');
    });
    AuthController().isLogin.value = false;
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFF1B2339),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ],
      ),
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ScreenResponsive.isTablet(context) ||
                        ScreenResponsive.isMobile(context)
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Logistics ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700)),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('Logistics ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                      ),
              ),
            ),
            buildListTile(
                'Tổng quan',
                const FaIcon(FontAwesomeIcons.solidChartBar,
                    color: Colors.white), () {
              onTap(0);
            }, context),
            buildListTile('Quản lý người dùng',
                const FaIcon(FontAwesomeIcons.userAlt, color: Colors.white),
                () {
              onTap(1);
            }, context),
            buildListTile('Vị trí làm việc',
                const FaIcon(FontAwesomeIcons.briefcase, color: Colors.white),
                () {
              onTap(2);
            }, context),
            buildListTile(
                'Quản lý chi nhánh',
                const FaIcon(FontAwesomeIcons.city, color: Colors.white),
                () {},
                context),
            buildListTile(
                'Quản lý trụ sở',
                const FaIcon(FontAwesomeIcons.building, color: Colors.white),
                () {},
                context),
            buildListTile(
                'Quản Lý Kho Hàng',
                const FaIcon(FontAwesomeIcons.warehouse, color: Colors.white),
                () {},
                context),
            buildListTile(
                'Quản lý cổng',
                const FaIcon(FontAwesomeIcons.arrowsTurnToDots, color: Colors.white),
                () {},
                context),
            buildListTile(
                'Quản lý phương tiện',
                const FaIcon(FontAwesomeIcons.truckMoving,
                    color: Colors.white),
                () {},
                context),
            buildListTile(
                'Quản Lý Hệ Thống',
                const FaIcon(FontAwesomeIcons.cogs, color: Colors.white),
                () {},
                context),
            buildListTile('Đăng Xuất',
                const FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
                () {
              handleLogout();
            }, context),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(
      String title, FaIcon icon, Function onTap, BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      leading: icon,
      title: Tooltip(
        message: title,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        onTap();
        ScreenResponsive.isTablet(context) || ScreenResponsive.isMobile(context)
            ? Get.back()
            : null;
      },
    );
  }
}
