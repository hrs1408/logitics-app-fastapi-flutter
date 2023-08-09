import 'package:app/models/dto/user_create.dart';
import 'package:app/models/user_information.dart';
import 'package:app/services/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/user_data.dart';
import '../models/user.dart';
import '../widgets/snack_bar/get_snack_bar.dart';

class UserController extends GetxController {
  Rx<UserDataSource> userDataSource = UserDataSource(users: []).obs;
  RxList<User> users = List<User>.empty(growable: true).obs;
  RxBool isLoading = false.obs;
  RxInt selectedId = 0.obs;
  Rx<User> userSelected = User(
    id: 0,
    email: '',
    userRole: '',
    branchId: 0,
    isActive: false,
    userInformation: UserInformation(
      fullName: '',
      phoneNumber: '',
      id: 0,
      dateOfBirth: DateTime.now().toString(),
      identityCardCode: '',
      userId: 0,
    ),
    vehicleId: 0,
    workPositionId: 0,
  ).obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('access_token');
    if (token == null) {
      Get.offAllNamed('/login');
    }
    return token!;
  }

  void getUsers() async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().getUsers(token);
      if (response != null) {
        users.assignAll(listUserFromJson(response.body));
      }
    } finally {
      isLoading.value = false;
      userDataSource.value = UserDataSource(users: users);
    }
  }

  Future<User> getUser(int id) async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().getUser(token, id);
      if (response != null) {
        userSelected.value = userFromJson(response.body);
      }
    } finally {
      isLoading.value = false;
    }
    return userSelected.value;
  }

  void createUser(UserCreate userCreate) async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().createNewUser(token, userCreate);
      if (response.statusCode == 200) {
        getUsers();
        Get.snackbar('Success', 'User created successfully');
      } else {
        Get.snackbar('Error', response.statusCode.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  void deleteUser(int id) async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().deleteUser(token, id);
      if (response.statusCode == 200) {
        getUsers();
        Get.snackbar('Success', 'User deleted successfully');
      } else {
        Get.snackbar('Error', response.statusCode.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  void deActiveUser(int id) async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().deActiveUser(token, id);
      if (response.statusCode == 200) {
        getUsers();
        getSnackBarLight('Thành công!', 'Đã khóa tài khoản thành công');
      } else {
        getSnackBarLight('Lỗi', response.statusCode.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  void activeUser(int id) async {
    try {
      isLoading.value = true;
      String token = await getToken();
      var response = await UserService().activeUser(token, id);
      if (response.statusCode == 200) {
        getUsers();
        getSnackBarLight('Thành công!', 'Mở khóa tài khoản thành công');
      } else {
        getSnackBarLight('Lỗi', response.statusCode.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
