import 'package:hip_quest/data/controller/BaseController.dart';
import 'package:hip_quest/data/dataSource/remote/dio/DioClient.dart';
import 'package:hip_quest/data/dataSource/remote/exception/ApiErrorHandler.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends BaseController {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LoginController({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> login(Map<String, dynamic> mobileData, context) async {
    showLoader(context);
    try {
      final response = await dioClient.post(AppConstants.login, data: mobileData);
      dismissLoader(context);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      dismissLoader(context);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e, isLogin: true));
    }
  }

  Future<void> saveUserDataInSession(
    String userId,
    String firstName,
    String lastName,
    String userEmail,
    String role,
    String profileImage,
    String occupation,
    String bio,
    String interest,
    String fcm,
  ) async {
    var token = '';
    // dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.userId, userId);
      await sharedPreferences.setString(AppConstants.firstName, firstName);
      await sharedPreferences.setString(AppConstants.lastName, lastName);
      await sharedPreferences.setString(AppConstants.userEmail, userEmail);
      await sharedPreferences.setString(AppConstants.profileImage, profileImage);
      await sharedPreferences.setString(AppConstants.role, role);
      await sharedPreferences.setString(AppConstants.occupation, occupation);
      await sharedPreferences.setString(AppConstants.interest, interest);
      await sharedPreferences.setString(AppConstants.fcmToken, fcm);
    } catch (e) {
      rethrow;
    }
  }
}
