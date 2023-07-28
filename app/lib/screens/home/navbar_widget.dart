import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFFFFD700),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text('Trang chủ',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {},
                  child: const Text('Vận chuyển',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {},
                  child: const Text('Dịch vụ',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {},
                  child: const Text('Tin tức',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {},
                  child: const Text('Giới thiệu',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
              const SizedBox(width: 20),
              TextButton(
                  onPressed: () {},
                  child: const Text('Liên hệ',
                      style: TextStyle(color: Colors.black, fontSize: 16))),
            ],
          ),
        ),
      ),
    );
  }
}
