import 'package:app/resources/screen_responsive.dart';
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
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenResponsive.isMobile(context) ? 20 : 100,
            vertical: 10),
        child: Row(
          children: [
            ScreenResponsive.isMobile(context)
                ? Expanded(
                    flex: 3,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu, color: Colors.white),
                    ))
                : const SizedBox(),
            Text('Logistic',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenResponsive.isMobile(context)
                        ? 20
                        : ScreenResponsive.isTablet(context)
                            ? 30
                            : 40,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            Expanded(
              child: ScreenResponsive.isDesktop(context)
                  ? const TextField(
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
                    )
                  : SizedBox(),
            ),
            const Spacer(),
            ScreenResponsive.isDesktop(context)
                ? buildAuthMethodDesktop()
                : buildAuthMethodMobile(),
          ],
        ),
      ),
    );
  }

  Row buildAuthMethodMobile() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.login, color: Colors.white),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person_add, color: Colors.white),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            Get.toNamed('/admin');
          },
          icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
        ),
      ],
    );
  }

  Row buildAuthMethodDesktop() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Đăng nhập',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text('Đăng ký',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            Get.toNamed('/admin');
          },
          child: const Text('Quản trị viên',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    );
  }
}
