import 'dart:convert';

List<WorkPosition> listWorkPositionFromJson(String value) =>
    List<WorkPosition>.from(json
        .decode(value)["data"]
        .map((item) => WorkPosition.workPositionFromJson(item)));

class WorkPosition {
  int id;
  String positionName;

  WorkPosition({
    required this.id,
    required this.positionName,
  });

  factory WorkPosition.workPositionFromJson(Map<String, dynamic> data) =>
      WorkPosition(
        id: data['id'],
        positionName: data['position_name'],
      );
}
