import 'package:app/screens/dashboard/banner_slicer_widget.dart';
import 'package:app/widgets/chart/line_chart.dart';
import 'package:flutter/material.dart';

import '../../resources/screen_responsive.dart';
import '../../widgets/chart/total_cod_chart.dart';

class MiddleChart extends StatelessWidget {
  const MiddleChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (ScreenResponsive.isTablet(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenResponsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width - 60) / 1.6
                : ScreenResponsive.isTablet(context)
                    ? MediaQuery.of(context).size.width - 40
                    : MediaQuery.of(context).size.width - 20,
            height: 435,
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
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Tổng số đơn',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  LineChartSample2()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
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
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Tình trạng thanh toán COD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              child: TotalCodChart(),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                child: BannerSlider(height: 360),
              )
            ],
          )
        ],
      );
    } else if (ScreenResponsive.isMobile(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenResponsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width - 60) / 1.6
                : ScreenResponsive.isTablet(context)
                    ? MediaQuery.of(context).size.width - 40
                    : MediaQuery.of(context).size.width - 20,
            height: 435,
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
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Tổng số đơn',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  LineChartSample2()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
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
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Tình trạng thanh toán COD',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            child: TotalCodChart(),
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              const BannerSlider(height: 360)
            ],
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: ScreenResponsive.isDesktop(context)
              ? (MediaQuery.of(context).size.width - 60) / 1.6
              : (MediaQuery.of(context).size.width - 60) / 1.32,
          height: 435,
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
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Tổng số đơn',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                LineChartSample2()
              ],
            ),
          ),
        ),
        Container(
            width: ScreenResponsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width - 60) / 5
                : (MediaQuery.of(context).size.width - 60) / 4,
            height: 435,
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
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tình trạng thanh toán COD',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      child: TotalCodChart(),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
