import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../dashboard/header_dashboard_widget.dart';

class BranchManagerScreen extends StatelessWidget {
  const BranchManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderDashboard(title: 'Quản lý chi nhánh'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quản lý chi nhánh',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                  Row(
                    children: [
                      //select province
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Hà Nội',
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.white),
                            onChanged: (String? newValue) {},
                            items: <String>[
                              'Hà Nội',
                              'Hồ Chí Minh',
                              'Đà Nẵng',
                              'Hải Phòng'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(fontSize: 16)),
                              );
                            }).toList(),
                            dropdownColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryBlue)),
                        child: const Text('Thêm chi nhánh'),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
