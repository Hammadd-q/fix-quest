class LoginModel {
  final String email;
  final String password;
  final String platform;
  final String deviceToken;

  const LoginModel({
    required this.email,
    required this.password,
    required this.platform,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'deviceType': platform,
      'fcmToken': deviceToken,
    };
  }
}
