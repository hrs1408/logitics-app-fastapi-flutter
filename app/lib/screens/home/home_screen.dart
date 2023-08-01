import 'package:app/screens/home/carousel_banner_widget.dart';
import 'package:app/screens/home/delivery_service_widget.dart';
import 'package:app/screens/home/footer_widget.dart';
import 'package:app/screens/home/home_header_widget.dart';
import 'package:app/screens/home/mode_of_operation.dart';
import 'package:app/screens/home/navbar_widget.dart';
import 'package:flutter/material.dart';

import 'contact_language_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ContactAndLanguage(),
            Header(),
            Navbar(),
            CarouselBanner(),
            DeliveryService(),
            ModeOfOperation(),
            Footer()
          ],
        ),
      )),
    );
  }
}
