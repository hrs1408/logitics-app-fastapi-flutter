import 'package:flutter/material.dart';

import '../../resources/screen_responsive.dart';
import '../../widgets/table/invoice_table.dart';
import 'banner_slicer_widget.dart';

class BottomTable extends StatelessWidget {
  const BottomTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (ScreenResponsive.isDesktop(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenResponsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width - 60) / 1.6
                : (MediaQuery.of(context).size.width - 60) / 1.32,
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
            child: const InvoiceTable(),
          ),
          const BannerSlider(
            height: 200,
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: ScreenResponsive.isDesktop(context)
              ? (MediaQuery.of(context).size.width - 60) / 1.6
              : (MediaQuery.of(context).size.width - 40),
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
          child: const InvoiceTable(),
        ),
      ],
    );
  }
}
