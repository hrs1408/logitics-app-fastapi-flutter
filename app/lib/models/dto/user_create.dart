class UserCreate {
  String email;
  String fullName;
  String password;
  String confirmPassword;
  String userRole;
  int userPositionId;

  UserCreate({
    required this.email,
    required this.fullName,
    required this.password,
    required this.confirmPassword,
    required this.userRole,
    required this.userPositionId,
  });

  Map toJson() => {
        "email": email,
        "full_name": fullName,
        "password": password,
        "confirm_password": confirmPassword,
        "user_role": userRole,
        "user_position_id": userPositionId,
      };
}
