import 'package:app/controllers/position_controller.dart';
import 'package:app/controllers/user_controller.dart';
import 'package:app/models/dto/user_create.dart';
import 'package:app/widgets/table/user_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../dashboard/header_dashboard_widget.dart';

class UserManagerScreen extends StatelessWidget {
  const UserManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    PositionController positionController = Get.put(PositionController());
    RxString role = 'client'.obs;
    RxInt positionId = 6.obs;
    TextEditingController fullNameTextController = TextEditingController();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();
    TextEditingController confirmPasswordTextController =
        TextEditingController();
    void handleCreateUser() {
      if (fullNameTextController.text.isEmpty ||
          emailTextController.text.isEmpty ||
          passwordTextController.text.isEmpty ||
          confirmPasswordTextController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill all fields');
      } else if (passwordTextController.text !=
          confirmPasswordTextController.text) {
        Get.snackbar('Error', 'Password and confirm password not match');
      } else {
        try {
          userController.createUser(UserCreate(
              email: emailTextController.text,
              fullName: fullNameTextController.text,
              password: passwordTextController.text,
              confirmPassword: confirmPasswordTextController.text,
              userRole: role.value,
              userPositionId: positionId.value));
        } catch (e) {
          Get.snackbar('Error', 'User created failed');
        } finally {
          fullNameTextController.clear();
          emailTextController.clear();
          passwordTextController.clear();
          confirmPasswordTextController.clear();
          role.value = 'client';
          positionId.value = 6;
        }
      }
    }

    void showFormDialog() {
      Get.defaultDialog(
        title: 'Thêm người dùng',
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        content: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              TextField(
                controller: fullNameTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tên người dùng',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mật khẩu',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nhập lại mật khẩu',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Obx(
                () => DropdownButtonFormField(
                  value: role.value,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vai trò',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'supper_admin',
                      child: Text('Quản trị hệ thống'),
                    ),
                    DropdownMenuItem(
                      value: 'admin',
                      child: Text('Quản trị viên'),
                    ),
                    DropdownMenuItem(
                      value: 'user',
                      child: Text('Nhân viên'),
                    ),
                    DropdownMenuItem(
                      value: 'client',
                      child: Text('Khách hàng'),
                    ),
                  ],
                  onChanged: (String? value) {
                    role.value = value!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              buildSelectPosition(positionId, positionController),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      handleCreateUser();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF00428D),
                        padding: const EdgeInsets.all(20)),
                    child: const Text('Thêm'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(20)),
                    child: const Text('Hủy'),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    final DataGridController dataGridControllerL = DataGridController();

    return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const HeaderDashboard(title: 'Quản lý người dùng'),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showFormDialog();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF00428D),
                    padding: const EdgeInsets.all(20)),
                child: const Text('Thêm người dùng'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Get.snackbar("ID người dùng đã chọn",
                        "ID: ${dataGridControllerL.selectedRows[0].getCells()[0].value}", colorText: Colors.white, margin: EdgeInsets.all(10));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00428D),
                      padding: const EdgeInsets.all(20)),
                  child: const Text('Xem thông tin'))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          UserTable(dataGridController: dataGridControllerL)
        ],
      ),
    )));
  }

  Obx buildSelectPosition(
      RxInt positionId, PositionController positionController) {
    return Obx(
      () => DropdownButtonFormField(
        value: positionId.value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Vị trí làm việc',
        ),
        items: positionController.positions
            .map(
              (e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.positionName == 'root'
                    ? 'Quản trị hệ thống'
                    : e.positionName == 'manager'
                        ? 'Quản lý chi nhánh'
                        : e.positionName == 'warehouse'
                            ? 'Nhân viên kho'
                            : e.positionName == 'driver'
                                ? 'Tài xế lái xe'
                                : e.positionName == 'delivery'
                                    ? 'Nhân viên giao hàng'
                                    : 'Khách hàng'),
              ),
            )
            .toList(),
        onChanged: (int? value) {
          positionId.value = value!;
        },
      ),
    );
  }
}
