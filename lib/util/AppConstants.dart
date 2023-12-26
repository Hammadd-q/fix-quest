class AppConstants {
  static const String baseUrl = 'https://dralisongrimaldi.com/wp-json/md-api/';
  static const String testBaseUrl =
      'https://dralisontest.wpengine.com/wp-json/md-api/';
  static const String lifterBaseUrl =
      'https://dralisongrimaldi.com/wp-json/llms/v1/';
  static const String mediaUrl = 'https://dralisongrimaldi.com/wp-json/wp/v2/';
  static const String stagingurl =
      "https://dralisongrimaldi.com/wp-json/md-api/";
  // 'https://staging.dralisongrimaldi.com/wp-json/md-api/';

  // Routes
  static const String login = 'users/login-user';
  static const String register = 'users/register';
  static const String forgotPassword = 'users/lost-password';
  static const String changePassword = 'users/change-password';
  static const String profile = 'users/profile';
  static const String blogs = 'posts?post_type=post';
  static const String post = 'posts/{postId}';
  static const String events = 'posts?post_type=tribe_events';
  static const String videoLibrary = 'posts?post_type=vimeo-video';
  static const String chatUsers = 'users';
  static const String freeResource = 'posts?post_type=free_resources_pdf';
  static const String allLearning = "${lifterBaseUrl}students/{id}/enrollments";
  static const String learningMedia = "${mediaUrl}media/{postId}";
  static const String ebook = "${lifterBaseUrl}memberships/{ebookId}";
  static const String course = "${lifterBaseUrl}courses/{courseId}";
  static const String courseProgress =
      "${lifterBaseUrl}students/{id}/progress/{courseId}";
  static const String courseSections =
      "${lifterBaseUrl}courses/{courseId}/content";
  static const String courseSection =
      "${lifterBaseUrl}sections/{sectionId}/content";

  // sharePreference
  static const String userId = 'user_id';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String userEmail = 'user_email';
  static const String role = 'role';
  static const String fcmToken = 'device_token';
  static const String profileImage = 'profile_image';
  static const String displayName = 'display_name';
  static const String occupation = 'occupation';
  static const String bio = 'bio';
  static const String interest = 'interest';
  static const String favoriteVideos = 'videos';

  // FCM SERVER KEYS
  static const String fcmBaseUrl = 'https://fcm.googleapis.com/fcm/send';
  static const String serverKey =
      'AAAAFwywcEc:APA91bH5ZUMvvjFIktbtSLaKJwZ5i9k5u84eRQaM9DfFBwsPGZqB1tl_n0Wp19H-9_gKCoKNwSkian22ewgx8ypgqxbwg22kQFmAHucRN-JVtGOXbfpLPQm5mUrmWw5JB_kXCin1xDya';
  static const String senderId = '98997137479';

  //Firebase Collections
  static const String firebaseUsers = 'users';
  static const String firebaseChatRooms = 'chatRooms';
  static const String firebaseMsg = '"messages"';

  static const String firebaseSingleChatCollection = 'chat';
  static const String firebaseChatUsers = 'chat_users';
  static const String firebaseSingleChatRoom = 'chatroom';
  static const String firebaseGroupChatRoom = 'group_chatroom';
  static const String firebaseNotifications = 'notifications';

  //Dummy Data
  static const String avatarDummyImage =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
}
