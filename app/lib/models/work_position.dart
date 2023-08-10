import 'dart:convert';

import 'package:app/models/user.dart';

List<WorkPosition> listWorkPositionFromJson(String value) =>
    List<WorkPosition>.from(json
        .decode(value)["data"]
        .map((item) => WorkPosition.workPositionFromJson(item)));

class WorkPosition {
  int id;
  String positionName;
  List<User> users;

  WorkPosition({
    required this.id,
    required this.positionName,
    required this.users,
  });

  factory WorkPosition.workPositionFromJson(Map<String, dynamic> data) =>
      WorkPosition(
        id: data['id'],
        positionName: data['position_name'],
        users: List<User>.from(
            data['users'].map((item) => User.userFromJson(item))),
      );
}
