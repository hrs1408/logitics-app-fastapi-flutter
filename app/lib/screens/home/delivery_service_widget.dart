import 'package:app/resources/app_colors.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeliveryService extends StatelessWidget {
  const DeliveryService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenResponsive.isMobile(context) ? 20 : 100,
          vertical: 40),
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Text(
              'DỊCH VỤ CHUYỂN PHÁT CỦA CHÚNG TÔI',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenResponsive.isDesktop(context) ? 30 : 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 20,
              children: [
                buildServiceItem(
                    'https://ntx.com.vn/images/website_v2/saving_service.webp',
                    '01',
                    'Giao hàng tiếp kiệm',
                    'Dịch vụ giao hàng với cước phí vận chuyển rẻ, thời gian giao hàng hợp lý. Giải pháp vận chuyển tiết kiệm tối đa chi phí, phù hợp với khách gửi hàng số lượng lớn mỗi ngày.',
                    context),
                const SizedBox(
                  width: 40,
                ),
                buildServiceItem(
                    'https://ntx.com.vn/images/website_v2/fast_service.webp',
                    '02',
                    'Giao hàng nhanh',
                    'Dịch vụ giao hàng đến người nhận. Phù hợp với chuyển phát nhanh thư từ, bưu phẩm ngay trong ngày với mức phí hợp lý.',
                    context),
                const SizedBox(
                  width: 40,
                ),
                buildServiceItem(
                    'https://ntx.com.vn/images/website_v2/timing_service.webp',
                    '03',
                    'Giao hàng hỏa tốc',
                    'Dịch vụ giao hàng theo khung thời gian yêu cầu của khách hàng. Hình thức giao nhận chủ động, khách hàng không mất thời gian chờ đợi.',
                    context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildServiceItem(
      String image, String number, String title, String content, context) {
    return Container(
      margin:  EdgeInsets.only(bottom: ScreenResponsive.isTablet(context) || ScreenResponsive.isMobile(context) ? 20 : 0),
      width: ScreenResponsive.isMobile(context)
          ? MediaQuery.sizeOf(context).width
          : 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                width: ScreenResponsive.isMobile(context)
                    ? MediaQuery.sizeOf(context).width
                    : 300,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: '$number. ',
                style: const TextStyle(
                    color: AppColors.secondaryYellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.arrowRight,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tìm hiểu thêm',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
