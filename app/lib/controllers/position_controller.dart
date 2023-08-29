import 'package:app/controllers/utils.dart';
import 'package:app/models/work_position.dart';
import 'package:app/services/position_service.dart';
import 'package:get/get.dart';

import '../widgets/snack_bar/get_snack_bar.dart';

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
      Utils utils = Utils();
      String token = await utils.getToken();
      var response = await PositionService().getPositions(token!);
      if (response != null) {
        positions.assignAll(listWorkPositionFromJson(response.body));
      }
    } finally {
      isLoading.value = false;
    }
  }

  void createPosition(String positionName) async {
    try {
      isLoading.value = true;
      Utils utils = Utils();
      String token = await utils.getToken();
      var response =
          await PositionService().createPosition(token, positionName);
      if (response.statusCode == 200) {
        getPositions();
        getSnackBarLight(
            'Create position success', response.statusCode.toString());
      } else {
        getSnackBarLight(
            'Create position failed', response.statusCode.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
