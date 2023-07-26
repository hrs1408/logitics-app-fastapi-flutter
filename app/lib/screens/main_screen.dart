import 'package:app/screens/dashboard/dash_board_screen.dart';
import 'package:app/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 1,
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0XFF0E6EDFA),
                  child: const DashboardScreen()),
            )
          ],
        ),
      ),
    );
  }
}
