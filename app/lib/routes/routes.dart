import 'package:app/middleware/admin_middleware.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/panel/delivery_panel/delivery_panel.dart';
import 'package:app/screens/register/register_screen.dart';
import 'package:get/get.dart';

import '../screens/panel/client_panel/client_panel.dart';
import '../screens/panel/driver_panel/driver_panel.dart';
import '../screens/panel/manager_panel/manager_panel.dart';
import '../screens/panel/warehouse_panel/warehouse_panel.dart';

class Routes {
  static String initial = '/home';

  static final routes = [
    GetPage(name: '/admin', page: () => const MainScreen(), middlewares: [
      AdminMiddleware(),
    ]),
    GetPage(name: '/home', page: () => const HomeScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(name: '/customer_panel', page: () => const ClientPanel()),
    GetPage(name: '/manager_panel', page: () => const ManagerPanel()),
    GetPage(name: '/warehouse_panel', page: () => const WarehousePanel()),
    GetPage(name: '/driver_panel', page: () => const DriverPanel()),
    GetPage(name: '/delivery_panel', page: () => const DeliveryPanel()),
  ];
}
