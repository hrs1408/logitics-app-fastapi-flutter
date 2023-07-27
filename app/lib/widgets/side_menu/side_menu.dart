import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  final Function onTap;

  const SideMenu({super.key, required this.onTap});

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
            const DrawerHeader(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('Logistics ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            buildListTile(
                'Tổng Quan',
                const FaIcon(FontAwesomeIcons.solidChartBar,
                    color: Colors.white),
                () {
                  onTap(0);
                }),
            buildListTile(
                'Quản Lý Người Dùng',
                const FaIcon(FontAwesomeIcons.userAlt, color: Colors.white),
                () {
                  onTap(1);
                }),
            buildListTile('Quản Lý Đơn Hàng',
                const FaIcon(FontAwesomeIcons.box, color: Colors.white), () {}),
            buildListTile(
                'Quản Lý Kho Hàng',
                const FaIcon(FontAwesomeIcons.warehouse, color: Colors.white),
                () {}),
            buildListTile(
                'Quản Lý Đối Tác',
                const FaIcon(FontAwesomeIcons.handshake, color: Colors.white),
                () {}),
            buildListTile(
                'Quản Lý Báo Cáo',
                const FaIcon(FontAwesomeIcons.fileInvoiceDollar,
                    color: Colors.white),
                () {}),
            buildListTile(
                'Quản Lý Hệ Thống',
                const FaIcon(FontAwesomeIcons.cogs, color: Colors.white),
                () {}),
            buildListTile('Đăng Xuất',
                const FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
                () {
              Get.toNamed('/login');
            }),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String title, FaIcon icon, Function onTap) {
    return ListTile(
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      leading: icon,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
