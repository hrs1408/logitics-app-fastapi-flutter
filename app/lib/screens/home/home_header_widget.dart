import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF00428D),
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Row(
          children: [
            const Text('Logistic', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
            const Spacer(),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm vận đơn...',
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text('Đăng ký', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/admin');
                  },
                  child: const Text('Quản trị viên', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
