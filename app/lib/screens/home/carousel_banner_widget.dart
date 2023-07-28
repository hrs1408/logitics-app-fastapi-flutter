import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<String> imageList = [
  'https://cdn.ntx.com.vn/uploads/banners/2021/12/28/BANNER-DOWN-APP-NTX_1.webp',
  'https://cdn.ntx.com.vn/uploads/banners/2021/12/28/1920x743-banner-web-_2_.webp',
];

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      color: Colors.white70,
      child: CarouselSlider(
          options: CarouselOptions(
            height: 700,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            disableCenter: true,
            viewportFraction: 1,
          ),
          items: imageList
              .map((item) => Center(
                      child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 700,
                  )))
              .toList()),
    );
  }
}
