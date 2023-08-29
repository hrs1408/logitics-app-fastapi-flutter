import 'package:app/resources/app_colors.dart';
import 'package:app/screens/dashboard/header_dashboard_widget.dart';
import 'package:app/screens/position_manager/position_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/position_controller.dart';
import '../../resources/screen_responsive.dart';

class PositionManagerScreen extends StatelessWidget {
  const PositionManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PositionController positionController = Get.put(PositionController());
    TextEditingController positionNameController = TextEditingController();

    void showCreatePositionDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Thêm vị trí',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: positionNameController,
                    decoration: const InputDecoration(
                        hintText: 'Tên vị trí',
                        hintStyle: TextStyle(color: Colors.black)),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Hủy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryBlue),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                        ),
                        onPressed: () {
                          positionController
                              .createPosition(positionNameController.text);
                          Get.back();
                        },
                        child: const Text(
                          'Thêm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderDashboard(title: 'Quản lý vị trí công việc'),
              const SizedBox(height: 40),
              const Text('Danh sách các vị trí',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenResponsive.isDesktop(context) ? 10 : 0,
                    vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10)),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryBlue)),
                      onPressed: () {
                        showCreatePositionDialog();
                      },
                      child: const Text('Thêm vị trí'),
                    ),
                  ],
                ),
              ),
              GridView(
                padding: const EdgeInsets.only(top: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenResponsive.isDesktop(context)
                        ? 3
                        : ScreenResponsive.isMobile(context)
                            ? 1
                            : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 5.5),
                shrinkWrap: true,
                children: positionController.positions
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          Get.to(() => PositionSubScreen(position: e));
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  buildPositionView(e.id),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Text(
                                  '${e.users.length} người dùng',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String buildPositionView(int id) {
    switch (id) {
      case 1:
        return 'Quản trị hệ thống';
      case 2:
        return 'Quản lý chi nhánh';
      case 3:
        return 'Quản lý kho';
      case 4:
        return 'Tài xế lái xe';
      case 5:
        return 'Nhân viên giao hàng';
      case 6:
        return 'Khách hàng';
      default:
        return 'Không xác định';
    }
  }
}
