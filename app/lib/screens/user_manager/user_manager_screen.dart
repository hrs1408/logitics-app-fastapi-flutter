import 'package:flutter/material.dart';

import '../dashboard/header_dashboard_widget.dart';

class UserManagerScreen extends StatelessWidget {
  const UserManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          HeaderDashboard(title: 'Quản lý người dùng'),
          SizedBox(height: 40),
        ],
      ),
    )));
  }
}
