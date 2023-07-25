import 'package:app/screens/main_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const initial = '/';

  static final routes = [
    GetPage(name: '/', page: () => const MainScreen()),
    GetPage(name: '/login', page: () => const MainScreen()),
  ];
}
