import 'package:app/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class InvoiceTable extends StatelessWidget {
  const InvoiceTable({super.key});

  @override
  Widget build(BuildContext context) {
    EmployeeController employeeController = Get.put(EmployeeController());
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
          child: SfDataGrid(
            columnWidthMode: ColumnWidthMode.fill,
            columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
            source: employeeController.employeeDataSource,
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
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Tên',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                  columnName: 'city',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Vị trí',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))),
              GridColumn(
                columnName: 'freight',
                label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Cước phí',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
