import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/chart.dart';

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
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          '${DateTime.now().hour} : ${DateTime.now().minute} | ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}')
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
                                  color: Colors.black),
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
                  buildBoxDashboard(context),
                  buildBoxDashboard(context),
                  buildBoxDashboard(context),
                  buildBoxDashboard(context),
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
                    child:  const LineChartSample1(),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 5,
                    height: 435,
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
                  ),
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
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 5,
                    height: 200,
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildBoxDashboard(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 5,
      height: 200,
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.userAlt,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                const Text('Tổng số đơn',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('1000',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FaIcon(FontAwesomeIcons.arrowUp, color: Colors.green),
                    SizedBox(width: 5),
                    Text('10%')
                  ],
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 150,
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: 20,
                      showTitle: false,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: 40,
                      showTitle: false,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 10,
                      showTitle: false,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      color: Colors.yellow,
                      value: 25,
                      showTitle: false,
                      radius: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
