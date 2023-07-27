import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../resources/screen_responsive.dart';

final List<String> imgList = [
  'https://mekongsoft.com.vn/assets/images/tintuc/845822162f998f1fe08e66b65c683aaf.jpg',
  'https://vimc.co/wp-content/uploads/2019/01/logistic-15413508476761205026565-0-5-320-575-crop-1541350855830863448122.jpg',
  'https://tuyensinh.cdtm.edu.vn/wp-content/uploads/2020/08/Logistics.jpg',
  'https://shipsy.io/wp-content/uploads/2022/10/Frame-1-4.png',
];

class BannerSlider extends StatelessWidget {
  final int height;
  const BannerSlider({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenResponsive.isDesktop(context)
          ? (MediaQuery.of(context).size.width - 60) / 5
          : ScreenResponsive.isMobile(context) ? MediaQuery.of(context).size.width - 20 : MediaQuery.of(context).size.width - 40,
      height: height.toDouble(),
      decoration: BoxDecoration(
        color: const Color(0XFF1B2339),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              viewportFraction: 1.0),
          items: imgList
              .map(
                (item) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
