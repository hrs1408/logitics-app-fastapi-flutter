import 'package:flutter/material.dart';

class ModeOfOperation extends StatelessWidget {
  const ModeOfOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: const Color(0XFFF9F9F9),
      child: Column(
        children: [
          const Text(
            'PHƯƠNG THỨC HOẠT ĐỘNG CỦA CHÚNG TÔI',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Image.network(
              'https://ntx.com.vn/images/website_v2/img_operation_pc.webp')
        ],
      ),
    );
  }
}
