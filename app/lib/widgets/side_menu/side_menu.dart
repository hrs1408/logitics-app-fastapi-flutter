import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
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
                child: Image.network(
                    'https://media.loveitopcdn.com/3807/logo-cong-ty-its-logistics-compressed.jpg'),
              ),
            ),
            buildListTile(
                'Tổng Quan', const FaIcon(FontAwesomeIcons.solidChartBar)),
            buildListTile(
                'Quản Lý Người Dùng', const FaIcon(FontAwesomeIcons.userAlt)),
            buildListTile(
                'Quản Lý Đơn Hàng', const FaIcon(FontAwesomeIcons.box)),
            buildListTile(
                'Quản Lý Kho Hàng', const FaIcon(FontAwesomeIcons.warehouse)),
            buildListTile(
                'Quản Lý Đối Tác', const FaIcon(FontAwesomeIcons.handshake)),
            buildListTile('Quản Lý Báo Cáo',
                const FaIcon(FontAwesomeIcons.fileInvoiceDollar)),
            buildListTile(
                'Quản Lý Hệ Thống', const FaIcon(FontAwesomeIcons.cogs)),
            buildListTile(
                'Đăng Xuất', const FaIcon(FontAwesomeIcons.signOutAlt)),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String title, FaIcon icon) {
    return ListTile(
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      leading: icon,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      onTap: () {
        Get.snackbar('Xin chào', 'Bạn đã chọn $title',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.black45,
            colorText: Colors.white,
            margin: const EdgeInsets.all(20));
      },
    );
  }
}
