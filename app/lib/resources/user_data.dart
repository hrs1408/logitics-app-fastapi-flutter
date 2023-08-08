import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({required List<User> users}) {
    dataGridRows = users
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
            ]))
        .toList();
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
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ));
        }).toList());
  }
}
