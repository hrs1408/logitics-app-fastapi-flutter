import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserDataSource extends DataGridSource {
  RxList<User> paginatedUsers = List<User>.empty(growable: true).obs;
  RxList<User> allUser = List<User>.empty(growable: true).obs;
  int perPage = 13;

  UserDataSource({required List<User> users}) {
    allUser.value = users.reversed.toList();
    getInitPaginatedUsers();
    buildDataGridRows();
  }

  void getInitPaginatedUsers() {
    paginatedUsers.value = allUser.take(perPage).toList();
  }

  List<DataGridRow> dataGridRows = [];

  String positionName(int positionId) {
    switch (positionId) {
      case 1:
        return 'Quản trị hệ thống';
      case 2:
        return 'Quản lý chi nhánh';
      case 3:
        return 'Nhân viên kho';
      case 4:
        return 'Tài xế lái xe';
      case 5:
        return 'Nhân viên giao hàng';
      default:
        return 'Khách hàng';
    }
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == 'id')
              ? Alignment.center
              : Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16.0,
                color: dataGridCell.value == 'Đang hoạt động'
                    ? Colors.green
                    : dataGridCell.value == 'Ngừng hoạt động'
                        ? Colors.red
                        : Colors.white),
          ));
    }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * perPage;
    int endIndex = startIndex + perPage;
    if (startIndex < allUser.value.length && endIndex <= allUser.value.length) {
      paginatedUsers.value =
          allUser.value.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
      notifyListeners();
    } else if (endIndex > allUser.value.length) {
      paginatedUsers.value = allUser.value
          .getRange(startIndex, allUser.value.length)
          .toList(growable: false);
      buildDataGridRows();
      notifyListeners();
    } else {
      paginatedUsers.value = List<User>.empty(growable: true);
      buildDataGridRows();
    }
    return true;
  }

  void buildDataGridRows() {
    dataGridRows = paginatedUsers.value
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                columnName: 'id',
                value: dataGridRow.id,
              ),
              DataGridCell<String>(
                  columnName: 'email', value: dataGridRow.email),
              DataGridCell<String>(
                  columnName: 'full_name',
                  value: dataGridRow.userInformation.fullName),
              DataGridCell<String>(
                columnName: 'role',
                value: dataGridRow.userRole == 'supper_admin'
                    ? 'Quản trị hệ thống'
                    : dataGridRow.userRole == 'admin'
                        ? 'Quản trị viên'
                        : dataGridRow.userRole == 'user'
                            ? 'Nhân viên'
                            : 'Khách hàng',
              ),
              DataGridCell<String>(
                columnName: 'user_position',
                value: positionName(dataGridRow.workPositionId),
              ),
              DataGridCell(
                  columnName: 'active',
                  value: dataGridRow.isActive
                      ? 'Đang hoạt động'
                      : 'Ngừng hoạt động'),
            ]))
        .toList(growable: false);
  }
}
