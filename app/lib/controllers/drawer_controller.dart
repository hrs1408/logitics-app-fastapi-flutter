import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerControllerE extends GetxController{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}
