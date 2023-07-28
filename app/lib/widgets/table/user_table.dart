import 'package:app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class InvoiceTable extends StatelessWidget {
  const InvoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: const Color(0XFF2B5DFF),
          filterIconColor: Colors.white,
          sortIconColor: Colors.white,
        ),
        child: Obx(() => SfDataGrid(
              columnWidthMode: ColumnWidthMode.fill,
              columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
              source: userController.userDataSource.value,
              allowSorting: true,
              allowMultiColumnSorting: true,
              columns: [
                GridColumn(
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
                  columnName: 'full_name',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'Họ và tên',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
