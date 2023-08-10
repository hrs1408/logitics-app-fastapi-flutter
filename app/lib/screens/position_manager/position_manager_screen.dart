import 'package:app/resources/app_colors.dart';
import 'package:app/screens/dashboard/header_dashboard_widget.dart';
import 'package:app/screens/position_manager/position_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/position_controller.dart';

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
          return AlertDialog(
            titlePadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            title: const Text('Thêm vị trí'),
            content: TextField(
              controller: positionNameController,
              decoration: const InputDecoration(
                  hintText: 'Nhập tên vị trí', border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Thêm'))
            ],
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
            GridView(
              padding: const EdgeInsets.only(top: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5),
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    showCreatePositionDialog();
                  },
                  child: const Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(height: 10),
                        Text('Thêm vị trí')
                      ],
                    ),
                  ),
                ),
                ...List.generate(
                  positionController.positions.length,
                  (index) => InkWell(
                    onTap: () {
                      Get.to(PositionSubScreen(
                          position: positionController.positions[index]));
                    },
                    child: Card(
                      color: AppColors.primaryBlue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            buildPositionView(
                                positionController.positions[index].id),
                            style: const TextStyle(
                                color: AppColors.secondaryYellow,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Số lượng người dùng: ${positionController.positions[index].users.length}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
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
