import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/chart/line_chart.dart';
import '../../widgets/chart/pie_chart.dart';
import '../../widgets/chart/total_cod_chart.dart';
import '../../widgets/table/invoice_table.dart';

final List<String> imgList = [
  'https://mekongsoft.com.vn/assets/images/tintuc/845822162f998f1fe08e66b65c683aaf.jpg',
  'https://vimc.co/wp-content/uploads/2019/01/logistic-15413508476761205026565-0-5-320-575-crop-1541350855830863448122.jpg',
  'https://tuyensinh.cdtm.edu.vn/wp-content/uploads/2020/08/Logistics.jpg',
  'https://shipsy.io/wp-content/uploads/2022/10/Frame-1-4.png',
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello Kruluz Utsman',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          '${DateTime.now().hour} : ${DateTime.now().minute} | ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                  const Spacer(),
                  //search input
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.black,
                          )),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              'Kruluz Utsman',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
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
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 1.6,
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
                      width: (MediaQuery.of(context).size.width - 60) / 5,
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
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 1.6,
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
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 5,
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildBoxDashboard(BuildContext context, FaIcon icon, String title,
      String value, Color bgColor, bool down) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 5,
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
