import 'package:app/resources/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF00428D),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenResponsive.isMobile(context) ? 20 : 100,
            vertical: 40),
        child: Column(
          children: [
            ScreenResponsive.isMobile(context) ? buildFooterContentMobile() : buildFooterContentDesktop(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                color: Colors.white,
              ),
            ),
            const Text(
              '© 2023 Logistics. All rights reserved.',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Row buildFooterContentDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Địa chỉ: 123 Nguyễn Văn Linh, Đà Nẵng',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.phoneAlt,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Số điện thoại: 0123456789',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Image.network(
                        'https://ntx.com.vn/images/website_v2/get-app-store.png')),
                const SizedBox(width: 20),
                InkWell(
                    onTap: () {},
                    child: Image.network(
                        'https://ntx.com.vn/images/website_v2/get-gg-play.png')),
              ],
            )
          ],
        ),
        const Spacer(),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Về chúng tôi',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Giới thiệu',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Điều khoản sử dụng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Chính sách bảo mật',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hỗ trợ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chính sách',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Khiếu nại & đền bù',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Quy trình gửi & nhận hàng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Trách nhiệm các bên',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hàng hóa cấm gửi',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Chính sách bảo mật',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Quy định đóng gói hàng hóa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hỗ trợ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hotline: 1919',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Email: contact@logistics.com',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Điều khoản sử dụng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Câu hỏi thường gặp',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Wrap buildFooterContentMobile() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      spacing: 20,
      runSpacing: 20,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Địa chỉ: 123 Nguyễn Văn Linh, Đà Nẵng',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.phoneAlt,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Số điện thoại: 0123456789',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {},
                  child: const FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Image.network(
                        'https://ntx.com.vn/images/website_v2/get-app-store.png')),
                const SizedBox(width: 20),
                InkWell(
                    onTap: () {},
                    child: Image.network(
                        'https://ntx.com.vn/images/website_v2/get-gg-play.png')),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Về chúng tôi',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Giới thiệu',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Điều khoản sử dụng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Chính sách bảo mật',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hỗ trợ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chính sách',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Khiếu nại & đền bù',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Quy trình gửi & nhận hàng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Trách nhiệm các bên',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hàng hóa cấm gửi',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Chính sách bảo mật',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Quy định đóng gói hàng hóa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hỗ trợ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Hotline: 1919',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Email: contact@logistics.com',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Điều khoản sử dụng',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const Text(
                'Câu hỏi thường gặp',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
