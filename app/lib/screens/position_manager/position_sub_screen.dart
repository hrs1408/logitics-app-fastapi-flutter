import 'package:app/models/work_position.dart';
import 'package:app/resources/app_colors.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class PositionSubScreen extends StatelessWidget {
  final WorkPosition position;

  const PositionSubScreen({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
          backgroundColor: AppColors.primaryBlue,
          leading: IconButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent)),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            getPositionName(position.positionName),
          ),
        ),
        body: Container(
          color: const Color(0XFF282E45),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: ScreenResponsive.isMobile(context) ? 20 : 40,
                    right: ScreenResponsive.isMobile(context) ? 20 : 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryBlue)),
                        child: Text(
                            'Thêm ${getPositionName(position.positionName)}'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: ScreenResponsive.isMobile(context) ? 20 : 40,
                    right: ScreenResponsive.isMobile(context) ? 20 : 40,
                  ),
                  child: Column(
                    children: position.users
                        .map((e) => buildUserItem(e, context))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildUserItem(User user, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ScreenResponsive.isMobile(context) ? 200 : 400,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Họ tên: ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: user.userInformation.fullName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: ScreenResponsive.isMobile(context) ? 200 : 400,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Email: ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: user.email,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScreenResponsive.isTablet(context) ||
                        ScreenResponsive.isDesktop(context)
                    ? TextButton(
                        onPressed: () {}, child: const Text('Xem chi tiết'))
                    : IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye)),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getPositionName(String position) {
    switch (position) {
      case 'root':
        return 'Quản trị hệ thống';
      case 'manager':
        return 'Quản lý chi nhánh';
      case 'warehouse':
        return 'Quản lý kho';
      case 'driver':
        return 'Tài xế lái xe';
      case 'delivery':
        return 'Nhân viên giao hàng';
      case 'client':
        return 'Khách hàng';
      default:
        return 'Không xác định';
    }
  }
}
