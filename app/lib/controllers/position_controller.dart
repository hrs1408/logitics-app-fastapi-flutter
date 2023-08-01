import 'package:app/models/work_position.dart';
import 'package:app/services/position_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PositionController extends GetxController {
  RxList<WorkPosition> positions = List<WorkPosition>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getPositions();
    super.onInit();
  }

  void getPositions() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('access_token');
      if (token == null) {
        Get.offAllNamed('/login');
      }
      var response = await PositionService().getPositions(token!);
      if (response != null) {
        positions.assignAll(listWorkPositionFromJson(response.body));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
