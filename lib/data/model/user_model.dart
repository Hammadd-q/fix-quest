class UserModel {
  String? userId;
  String? userName;
  String? userLastName;
  String? userEmail;
  String? userDpUrl; // ? dp = display picture or profile picture url
  String? password;
  String? fcmKey;
  String? time;
  String? createdAt;
  bool? isOnline;

  UserModel({
    this.userId,
    this.userName,
    this.userLastName,
    this.userEmail,
    this.userDpUrl,
    this.password,
    this.fcmKey,
    this.time,
    this.createdAt,
    this.isOnline,
  });

  // ? you have user model instance, convert it to a map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userLastName': userLastName,
      'userEmail': userEmail,
      'userDpUrl': userDpUrl,
      'password': password,
      'fcmKey': fcmKey,
      'time': time,
      'createdAt': createdAt,
      'isOnline': isOnline,
    };
  }

  // ? recieve map and conert it to user model instance
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userLastName: map['userLastName'] != null ? map['userLastName'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userDpUrl: map['userDpUrl'] != null ? map['userDpUrl'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      fcmKey: map['fcmKey'] != null ? map['fcmKey'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
    );
  }
}