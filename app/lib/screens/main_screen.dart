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
          children: [
            const Expanded(
              flex: 1,
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  color: const Color(0xFF212332),
                  child: const DashboardScreen()),
            )
          ],
        ),
      ),
    );
  }
}
