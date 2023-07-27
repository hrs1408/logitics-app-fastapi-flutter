import 'package:flutter/material.dart';

class ScreenResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 750;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 750 &&
      MediaQuery.of(context).size.width <= 1500;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1500;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width > 1500) {
      return desktop;
    } else if (_size.width >= 751 && _size.width <= 1500) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
