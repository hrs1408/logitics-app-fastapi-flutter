class UserUpdate {
  String email;
  String fullName;
  String userRole;
  int userPositionId;
  String phoneNumber;
  String identityCardCode;
  String dateOfBirth;

  UserUpdate({
    required this.email,
    required this.fullName,
    required this.userRole,
    required this.userPositionId,
    required this.phoneNumber,
    required this.identityCardCode,
    required this.dateOfBirth,
  });

  Map toJson() => {
        "email": email,
        "full_name": fullName,
        "user_role": userRole,
        "user_position_id": userPositionId,
        "phone_number": phoneNumber,
        "identity_card_code": identityCardCode,
        "date_of_birth": dateOfBirth,
      };
}
