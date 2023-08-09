import 'package:app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UserTable extends StatelessWidget {
  final DataGridController dataGridController;

  const UserTable({super.key, required this.dataGridController});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          selectionColor: const Color(0XFF2B5DFF).withOpacity(0.4),
          headerColor: const Color(0XFF2B5DFF),
          filterIconColor: Colors.white,
          sortIconColor: Colors.white,
        ),
        child: Obx(
          () => SfDataGrid(
            columnWidthMode: ColumnWidthMode.fill,
            columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
            source: userController.userDataSource.value,
            allowSorting: true,
            allowMultiColumnSorting: true,
            selectionMode: SelectionMode.single,
            controller: dataGridController,
            columns: <GridColumn>[
              GridColumn(
                  width: 100,
                  columnName: 'id',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'ID',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'email',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Email',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'full_name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Tên đầy đủ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'role',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Vai trò',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'user_position',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Vị trí',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'active',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Trạng thái',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
