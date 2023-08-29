import 'package:app/controllers/user_controller.dart';
import 'package:app/resources/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UserTable extends StatelessWidget {
  final DataGridController dataGridController;

  UserTable({super.key, required this.dataGridController});

  final double _dataPagerHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    double width = MediaQuery.of(context).size.width;
    Rx<UserDataSource> userDataSource =
        UserDataSource(users: userController.users).obs;
    ever(
        userController.users,
        (callback) => {
              userDataSource.value = UserDataSource(users: callback.toList()),
            });
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => SfDataGrid(
                  columnWidthMode: ColumnWidthMode.fill,
                  columnWidthCalculationRange:
                      ColumnWidthCalculationRange.allRows,
                  source: userDataSource.value,
                  allowSorting: true,
                  allowMultiColumnSorting: true,
                  selectionMode: SelectionMode.single,
                  controller: dataGridController,
                  rowsPerPage: userDataSource.value.perPage,
                  columns: <GridColumn>[
                    GridColumn(
                        width: 80,
                        columnName: 'id',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'ID',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'email',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Email',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'full_name',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Tên đầy đủ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'role',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Vai trò',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'user_position',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Vị trí',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ))),
                    GridColumn(
                        columnName: 'active',
                        label: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
            SizedBox(
              height: _dataPagerHeight,
              child: SfDataPagerTheme(
                data: SfDataPagerThemeData(
                  itemBorderRadius: BorderRadius.circular(5),
                  itemTextStyle: const TextStyle(color: Colors.white),
                  itemBorderColor: Colors.white,
                ),
                child: Obx(
                  () => SfDataPager(
                    delegate: userDataSource.value,
                    direction: Axis.horizontal,
                    pageCount: userDataSource.value.allUser.length ~/
                            userDataSource.value.perPage +
                        1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
