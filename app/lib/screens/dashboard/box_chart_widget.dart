import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../resources/screen_responsive.dart';
import '../../widgets/chart/pie_chart.dart';

class BoxChartWidget extends StatelessWidget {
  const BoxChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (ScreenResponsive.isDesktop(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildBoxDashboard(
              context,
              const FaIcon(FontAwesomeIcons.fileInvoice,
                  color: Colors.white, size: 30),
              'Tổng số đơn COD',
              '1825',
              Colors.green,
              true),
          buildBoxDashboard(
              context,
              const FaIcon(FontAwesomeIcons.wallet,
                  color: Colors.white, size: 30),
              'Tổng COD đã thu',
              '985',
              Colors.yellow,
              false),
          buildBoxDashboard(
              context,
              const FaIcon(FontAwesomeIcons.moneyBill,
                  color: Colors.white, size: 30),
              'Tổng cước phí',
              '5.275.000',
              Colors.blueAccent,
              true),
          buildBoxDashboard(
              context,
              const FaIcon(FontAwesomeIcons.sackDollar,
                  color: Colors.white, size: 30),
              'Tổng COD còn lại',
              '840',
              Colors.cyan,
              false),
        ],
      );
    } else if (ScreenResponsive.isTablet(context)) {
      return Row(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildBoxDashboard(
                      context,
                      const FaIcon(FontAwesomeIcons.fileInvoice,
                          color: Colors.white, size: 30),
                      'Tổng số đơn COD',
                      '1825',
                      Colors.green,
                      true),
                  const SizedBox(
                    width: 20,
                  ),
                  buildBoxDashboard(
                      context,
                      const FaIcon(FontAwesomeIcons.wallet,
                          color: Colors.white, size: 30),
                      'Tổng COD đã thu',
                      '985',
                      Colors.yellow,
                      false),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildBoxDashboard(
                      context,
                      const FaIcon(FontAwesomeIcons.moneyBill,
                          color: Colors.white, size: 30),
                      'Tổng cước phí',
                      '5.275.000',
                      Colors.blueAccent,
                      true),
                  const SizedBox(
                    width: 20,
                  ),
                  buildBoxDashboard(
                      context,
                      const FaIcon(FontAwesomeIcons.sackDollar,
                          color: Colors.white, size: 30),
                      'Tổng COD còn lại',
                      '840',
                      Colors.cyan,
                      false),
                ],
              )
            ],
          )
        ],
      );
    } else if (ScreenResponsive.isMobile(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              buildBoxDashboard(
                  context,
                  const FaIcon(FontAwesomeIcons.fileInvoice,
                      color: Colors.white, size: 30),
                  'Tổng số đơn COD',
                  '1825',
                  Colors.green,
                  true),
              const SizedBox(height: 20),
              buildBoxDashboard(
                  context,
                  const FaIcon(FontAwesomeIcons.wallet,
                      color: Colors.white, size: 30),
                  'Tổng COD đã thu',
                  '985',
                  Colors.yellow,
                  false),
              const SizedBox(height: 20),
              buildBoxDashboard(
                  context,
                  const FaIcon(FontAwesomeIcons.moneyBill,
                      color: Colors.white, size: 30),
                  'Tổng cước phí',
                  '5.275.000',
                  Colors.blueAccent,
                  true),
              const SizedBox(height: 20),
              buildBoxDashboard(
                  context,
                  const FaIcon(FontAwesomeIcons.sackDollar,
                      color: Colors.white, size: 30),
                  'Tổng COD còn lại',
                  '840',
                  Colors.cyan,
                  false),
            ],
          )
        ],
      );
    }
    return const Row();
  }

  Container buildBoxDashboard(BuildContext context, FaIcon icon, String title,
      String value, Color bgColor, bool down) {
    return Container(
      width: ScreenResponsive.isDesktop(context)
          ? (MediaQuery.of(context).size.width - 60) / 5
          : ScreenResponsive.isTablet(context)
              ? (MediaQuery.of(context).size.width - 60) / 2
              : ScreenResponsive.isMobile(context)
                  ? (MediaQuery.of(context).size.width - 40)
                  : 0,
      height: 200,
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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: icon,
                  ),
                ),
                const Spacer(),
                Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 10),
                Text(value,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    down
                        ? const FaIcon(FontAwesomeIcons.arrowDown,
                            color: Colors.red)
                        : const FaIcon(FontAwesomeIcons.arrowUp,
                            color: Colors.green),
                    const SizedBox(width: 5),
                    const Text(
                      '10%',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            const Spacer(),
            const SizedBox(
              width: 100,
              height: 100,
              child: PieChartSample3(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
