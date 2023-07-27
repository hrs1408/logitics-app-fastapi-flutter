import 'package:app/screens/login/login_screen.dart';
import 'package:app/screens/main_screen.dart';
import 'package:app/screens/register/register_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const initial = '/';

  static final routes = [
    GetPage(name: '/', page: () => const MainScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen())
  ];
}
