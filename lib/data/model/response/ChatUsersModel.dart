class ChatUsersModel {
  int id;
  String name;
  String email;
  List<dynamic> userImg;
  List<dynamic> fcmToken;

  ChatUsersModel(
    this.id,
    this.name,
    this.email,
    this.userImg,
    this.fcmToken,
  );

  static ChatUsersModel fromJson(Map<String, dynamic> json) {
    return ChatUsersModel(
      json['id'],
      json['display_name'],
      json['user_email'],
      json['user_img'] ?? [],
      json['fcm_token'] ?? [],
    );
  }
}
