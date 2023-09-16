import 'package:app/controllers/utils.dart';
import 'package:app/services/province_service.dart';
import 'package:app/widgets/snack_bar/get_snack_bar.dart';
import 'package:get/get.dart';

class ProvinceController extends GetxController {
  RxList province = [].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getProvince();
    super.onInit();
  }

  void getProvince() async {
    try {
      isLoading.value = true;
      Utils utils = Utils();
      String token = await utils.getToken();
      var response = await ProvinceService().getAllProvince(token!);
      province.assignAll(response);
    } catch (e) {
      getSnackBarLight("Lỗi", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
