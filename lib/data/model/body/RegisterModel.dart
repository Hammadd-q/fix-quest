

class RegisterModel {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? deviceToken;
  String? platform;

  Map<String, String?> toJson() {
    return {
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "fcmToken": deviceToken,
      "deviceType": platform,
      "health_professional": "Y",
      "terms_condition_agree": "Y"
    };
  }
}
