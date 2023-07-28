import 'package:app/controllers/auth_controller.dart';
import 'package:app/middleware/admin_middleware.dart';
import 'package:app/screens/client_panel/client_panel.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/register/register_screen.dart';
import 'package:get/get.dart';

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
  ];
}
