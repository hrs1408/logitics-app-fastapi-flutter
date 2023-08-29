import 'dart:io';

import 'package:app/controllers/position_controller.dart';
import 'package:app/controllers/user_controller.dart';
import 'package:app/models/dto/user_create.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:app/widgets/snack_bar/get_snack_bar.dart';
import 'package:app/widgets/table/user_table.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../models/user.dart';
import '../dashboard/header_dashboard_widget.dart';

class UserManagerScreen extends StatelessWidget {
  const UserManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    PositionController positionController = Get.put(PositionController());
    RxString role = 'client'.obs;
    RxInt positionId = 6.obs;
    RxInt branchId = 1.obs;
    TextEditingController fullNameTextController = TextEditingController();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();
    TextEditingController confirmPasswordTextController =
        TextEditingController();
    TextEditingController phoneNumberTextController = TextEditingController();
    TextEditingController identityCardCodeTextController =
        TextEditingController();
    TextEditingController dateOfBirthTextController = TextEditingController();

    void handleCreateUser() {
      if (fullNameTextController.text.isEmpty ||
          emailTextController.text.isEmpty ||
          passwordTextController.text.isEmpty ||
          confirmPasswordTextController.text.isEmpty) {
        getSnackBarLight('Lỗi', 'Vui lòng điền đầy đủ các thông tin.');
      } else if (passwordTextController.text !=
          confirmPasswordTextController.text) {
        getSnackBarLight(
            'Lỗi', 'Mật khẩu và xác nhận mật khẩu không trùng khớp');
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
          getSnackBarLight('Lỗi', 'Có lỗi xảy ra. Vui lòng thử lại sau.');
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

    void handleEditUser() {}

    void showFormEditDialog(int id) {
      User user = userController.users.firstWhere((user) => user.id == id);
      fullNameTextController.text = user.userInformation.fullName;
      emailTextController.text = user.email;
      role.value = user.userRole;
      positionId.value = user.workPositionId;
      phoneNumberTextController.text = user.userInformation.phoneNumber;
      identityCardCodeTextController.text =
          user.userInformation.identityCardCode;
      dateOfBirthTextController.text = user.userInformation.dateOfBirth;
      Get.defaultDialog(
        title: 'Chỉnh sửa thông tin người dùng',
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
              buildSelectRole(role),
              const SizedBox(height: 20),
              buildSelectPosition(positionId, positionController),
              const SizedBox(height: 20),
              TextField(
                controller: phoneNumberTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Số điện thoại',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: identityCardCodeTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Số giấy tờ',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: dateOfBirthTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ngày sinh',
                ),
              ),
              const SizedBox(height: 20),
              buildFormMethod(handleEditUser),
            ],
          ),
        ),
      );
    }

    void showFormAddDialog() {
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
              buildSelectRole(role),
              const SizedBox(height: 20),
              buildSelectPosition(positionId, positionController),
              const SizedBox(height: 20),
              buildFormMethod(handleCreateUser),
            ],
          ),
        ),
      );
    }

    void deleteUser(int id) {
      try {
        userController.deleteUser(id);
        getSnackBarLight('Thành công!', 'Đã xóa người dùng khỏi hệ thống');
      } catch (e) {
        getSnackBarLight('Lỗi', 'Xóa người dùng không thành công!');
      }
    }

    void showConfirmDialog(int id) {
      Get.dialog(
        AlertDialog(
          title: const Text('Xóa người dùng'),
          content: const Text('Bạn có chắc chắn muốn xóa người dùng này?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                deleteUser(id);
                Get.back();
              },
              child: const Text('Xóa'),
            ),
          ],
        ),
      );
    }

    Future<void> showInfoUser(int id) async {
      User userInfo = await userController.getUser(id);
      Get.defaultDialog(
        title: 'Thông tin người dùng: $id',
        titleStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        titlePadding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        content: Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.network(
                    'https://img.freepik.com/free-icon/user_318-563642.jpg?w=360',
                    width: 250,
                    height: 250,
                  )
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Họ và tên: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.userInformation.fullName),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Email: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.email),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Vai trò: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      buildRoleView(userInfo.userRole)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Chức vụ: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      buildPositionView(userInfo.workPositionId)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Ngày sinh: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.userInformation.dateOfBirth),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Số giấy tờ: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.userInformation.identityCardCode),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Số điện thoại: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.userInformation.phoneNumber),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Chi nhánh: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(userInfo.branchId.toString()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Hoạt động: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userInfo.isActive
                            ? 'Đang hoạt động'
                            : 'Không hoạt động',
                        style: TextStyle(
                            color:
                                userInfo.isActive ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    bool checkSelectedRow(dataGridControllerL) {
      if (dataGridControllerL.selectedRows.isEmpty) {
        getSnackBarLight('Lỗi', 'Vui lòng chọn người dùng muốn thao tác');
        return false;
      }
      return true;
    }

    final DataGridController dataGridControllerL = DataGridController();
    GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

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
                  showFormAddDialog();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF00428D),
                    padding: const EdgeInsets.all(20)),
                child: ScreenResponsive.isMobile(context)
                    ? const Icon(Icons.add)
                    : const Text('Thêm người dùng'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    if (checkSelectedRow(dataGridControllerL)) {
                      showInfoUser(dataGridControllerL.selectedRows[0]
                          .getCells()[0]
                          .value);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00428D),
                      padding: const EdgeInsets.all(20)),
                  child: ScreenResponsive.isMobile(context)
                      ? const Icon(Icons.info)
                      : const Text('Thông tin người dùng')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    if (checkSelectedRow(dataGridControllerL)) {
                      showFormEditDialog(dataGridControllerL.selectedRows[0]
                          .getCells()[0]
                          .value);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00428D),
                      padding: const EdgeInsets.all(20)),
                  child: ScreenResponsive.isMobile(context)
                      ? const Icon(Icons.edit)
                      : const Text('Chỉnh sửa')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    if (checkSelectedRow(dataGridControllerL)) {
                      showConfirmDialog(dataGridControllerL.selectedRows[0]
                          .getCells()[0]
                          .value);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF00428D),
                      padding: const EdgeInsets.all(20)),
                  child: ScreenResponsive.isMobile(context)
                      ? const Icon(Icons.delete)
                      : const Text('Xóa'))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      PdfDocument? document =
                          key.currentState!.exportToPdfDocument();
                      final List<int> bytes = document.saveSync();
                      File('DataGrid.pdf').writeAsBytes(bytes);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF00428D),
                        padding: const EdgeInsets.all(20)),
                    child: ScreenResponsive.isMobile(context)
                        ? const FaIcon(
                            FontAwesomeIcons.filePdf,
                            color: Colors.white,
                          )
                        : const Text('Xuất file pdf'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF00428D),
                          padding: const EdgeInsets.all(20)),
                      child: ScreenResponsive.isMobile(context)
                          ? const FaIcon(
                              FontAwesomeIcons.fileExcel,
                              color: Colors.white,
                            )
                          : const Text('Xuất file excel')),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (checkSelectedRow(dataGridControllerL)) {
                        userController.deActiveUser(dataGridControllerL
                            .selectedRows[0]
                            .getCells()[0]
                            .value);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(20)),
                    child: ScreenResponsive.isMobile(context)
                        ? const FaIcon(
                            FontAwesomeIcons.lock,
                            color: Colors.white,
                          )
                        : const Text('Khóa tài khoản'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (checkSelectedRow(dataGridControllerL)) {
                        userController.activeUser(dataGridControllerL
                            .selectedRows[0]
                            .getCells()[0]
                            .value);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(20)),
                    child: ScreenResponsive.isMobile(context)
                        ? const FaIcon(
                            FontAwesomeIcons.unlock,
                            color: Colors.white,
                          )
                        : const Text('Mở khóa tài khoản'),
                  )
                ],
              )
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

  Row buildFormMethod(Function handle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            handle();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF00428D),
              padding: const EdgeInsets.all(20)),
          child: const Text('Lưu'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, padding: const EdgeInsets.all(20)),
          child: const Text('Hủy'),
        )
      ],
    );
  }

  Obx buildSelectRole(RxString role) {
    return Obx(
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
    );
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

  Text buildRoleView(String role) {
    switch (role) {
      case 'supper_admin':
        return const Text('Quản trị hệ thống');
      case 'admin':
        return const Text('Quản trị viên');
      case 'user':
        return const Text('Nhân viên');
      default:
        return const Text('Khách hàng');
    }
  }

  Text buildPositionView(int id) {
    switch (id) {
      case 1:
        return const Text('Quản trị hệ thống');
      case 2:
        return const Text('Quản lý chi nhánh');
      case 3:
        return const Text('Nhân viên kho');
      case 4:
        return const Text('Tài xế lái xe');
      case 5:
        return const Text('Nhân viên giao hàng');
      default:
        return const Text('Khách hàng');
    }
  }
}
