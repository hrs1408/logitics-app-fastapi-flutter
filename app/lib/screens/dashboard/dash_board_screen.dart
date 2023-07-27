import 'package:app/screens/dashboard/bottom_table.widget.dart';
import 'package:app/screens/dashboard/box_chart_widget.dart';
import 'package:app/screens/dashboard/header_dashboard_widget.dart';
import 'package:flutter/material.dart';

import 'middle_chart_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              HeaderDashboard(),
              SizedBox(height: 40),
              BoxChartWidget(),
              SizedBox(height: 20),
              MiddleChart(),
              SizedBox(height: 20),
              BottomTable()
            ],
          ),
        ),
      ),
    );
  }
}
