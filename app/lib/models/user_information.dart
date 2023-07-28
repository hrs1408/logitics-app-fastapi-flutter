import 'dart:convert';

UserInformation userInformationFromJson(String str) =>
    UserInformation.userFromJson(json.decode(str));

class UserInformation {
  int id;
  String fullName;
  String phoneNumber;
  String dateOfBirth;
  String identityCardCode;
  int userId;

  UserInformation({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.identityCardCode,
    required this.userId,
  });

  factory UserInformation.userFromJson(Map<String, dynamic> data) =>
      UserInformation(
        id: data['id'] ?? 0,
        fullName: data['full_name'] ?? '',
        phoneNumber: data['phone_number'] ?? '',
        dateOfBirth: data['date_of_birth'] ?? '',
        identityCardCode: data['identity_card_code'] ?? '',
        userId: data['user_id'] ?? 0,
      );
}
