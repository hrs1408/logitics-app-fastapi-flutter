import 'package:app/resources/screen_responsive.dart';
import 'package:app/screens/branch_manager/branch_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_colors.dart';
import '../dashboard/header_dashboard_widget.dart';

class BranchManagerScreen extends StatelessWidget {
  const BranchManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderDashboard(title: 'Quản lý chi nhánh'),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quản lý chi nhánh',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Row(
                children: [
                  //select province
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10)),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryBlue)),
                    child: const Text('Thêm chi nhánh'),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.height - 170,
            child: SingleChildScrollView(
              child: GridView.count(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: ScreenResponsive.isTablet(context) ||
                        ScreenResponsive.isDesktop(context)
                    ? 2
                    : 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
                children: [
                  for (int i = 0; i < 10; i++) buildBranchItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  InkWell buildBranchItem() => InkWell(
        onTap: () {
          Get.to(() => const BranchDetailsScreen());
        },
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_city,
                      color: AppColors.primaryBlue,
                      size: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.manage_accounts_rounded,
                        'Quản lý chi nhánh: Nguyen Van A'),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.phone, 'Số điện thoại: 0559797796'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextItem(Icons.drive_file_rename_outline,
                        'Tên chi nhánh: HANOI-SOC'),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.location_on, 'Tỉnh thành: Hà Nội'),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.location_city, 'Trung tâm: 10'),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.people, 'Số nhân viên: 10'),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextItem(Icons.fire_truck, 'Phương tiện: 20'),
                  ],
                ),
              ],
            )),
      );

  Row buildTextItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryBlue),
        ),
      ],
    );
  }
}
