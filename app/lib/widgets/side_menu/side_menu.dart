import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF2A2D3E),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.network(
                    'https://sanchenglogistics.com/image/catalog/logo/sancheng.png')),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Thống kê',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {
                Get.snackbar('Hello', 'This is dashboard',
                    snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, margin: const EdgeInsets.all(20));
              },
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.people_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Người dùng',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.location_history_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Vị trí làm việc',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.maps_home_work_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Chi nhánh',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.house_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Trung tâm điều hành',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.warehouse_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Kho/ bãi',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.import_export_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Cổng ra/vào',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.fire_truck_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Phương tiện',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(
                Icons.inventory_outlined,
                color: Colors.white54,
              ),
              title: const Text(
                'Đơn hàng',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w500
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
