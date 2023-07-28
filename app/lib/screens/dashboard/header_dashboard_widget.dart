import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/drawer_controller.dart';
import 'package:app/resources/screen_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HeaderDashboard extends StatelessWidget {
  final String title;

  const HeaderDashboard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildHeaderLeft(context),
        const Spacer(),
        //search input
        buildSearchBar(context),
        const Spacer(),
        buildHeaderRight(context)
      ],
    );
  }

  Row buildHeaderRight(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    if (ScreenResponsive.isMobile(context)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                )
              ],
            ),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
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
          child: Row(
            children: [
              Obx(
                () => Text(
                  authController.userLogin.value!.userInformation.fullName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
              )
            ],
          ),
        )
      ],
    );
  }

  Container buildSearchBar(BuildContext context) {
    if (ScreenResponsive.isDesktop(context) ||
        ScreenResponsive.isTablet(context)) {
      return Container(
        width: ScreenResponsive.isTablet(context) ? 250 : 350,
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
      );
    }
    return Container();
  }

  Column buildHeaderLeft(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    DrawerControllerE drawerControllerE = Get.put(DrawerControllerE());
    if (ScreenResponsive.isMobile(context)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    drawerControllerE.scaffoldKey.currentState!.openDrawer();
                  },
                  icon:
                      const FaIcon(FontAwesomeIcons.bars, color: Colors.white)),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          )
        ],
      );
    } else if (ScreenResponsive.isTablet(context)) {
      return Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    drawerControllerE.scaffoldKey.currentState!.openDrawer();
                  },
                  icon:
                      const FaIcon(FontAwesomeIcons.bars, color: Colors.white)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Hello ${authController.userLogin.value!.userInformation.fullName}',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                      '${DateTime.now().hour} : ${DateTime.now().minute} | ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: const TextStyle(color: Colors.white))
                ],
              )
            ],
          )
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            'Hello ${authController.userLogin.value!.userInformation.fullName}',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
            '${DateTime.now().hour} : ${DateTime.now().minute} | ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: const TextStyle(color: Colors.white))
      ],
    );
  }
}
