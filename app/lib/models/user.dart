import 'dart:convert';

import 'package:app/models/user_information.dart';

List<User> listUserFromJson(String value) => List<User>.from(
    json.decode(value)["data"].map((item) => User.userFromJson(item)));

User userFromJson(String value) => User.userFromJson(json.decode(value)["data"]);

class User {
  int id;
  String email;
  String userRole;
  int workPositionId;
  int branchId;
  int vehicleId;
  bool isActive;
  UserInformation userInformation;

  User({
    required this.id,
    required this.email,
    required this.userRole,
    required this.workPositionId,
    required this.branchId,
    required this.vehicleId,
    required this.isActive,
    required this.userInformation,
  });

  factory User.userFromJson(Map<String, dynamic> data) => User(
      id: data['id'],
      email: data['email'],
      userRole: data['user_role'],
      workPositionId: data['user_position_id'],
      branchId: data['branch_id'] ?? 0,
      vehicleId: data['vehicle_id'] ?? 0,
      isActive: data['is_active'],
      userInformation:
          UserInformation.userFromJson(data['user_information'] ?? {}));
}
