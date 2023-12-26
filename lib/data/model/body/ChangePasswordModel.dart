class ChangePasswordModel {
   String? email;
   String? oldPassword;
   String? newPassword;

  Map<String, dynamic> toJson() {
    return {
      'user_login': email,
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }
}
