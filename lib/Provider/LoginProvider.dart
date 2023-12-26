import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/data/controller/LoginController.dart';
import 'package:hip_quest/data/model/ValidationItem.dart';
import 'package:hip_quest/data/model/body/LoginModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/helper/NotificationHelper.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/user_model.dart';

class LoginProvider extends ChangeNotifier {
  final LoginController loginController;
  final SharedPreferences prefs;

  LoginProvider({
    required this.loginController,
    required this.prefs,
  });

  ValidationItem _email = ValidationItem(null, "Email is not valid");
  ValidationItem _password = ValidationItem(null, "Password is required");

  ValidationItem get email => _email;

  ValidationItem get password => _password;

  void setEmail(String value) {
    _email = ValidationItem(null, "Email is not valid");
    if (Helpers.checkEmail(value)) {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setPassword(String value) {
    _password = ValidationItem(null, "Password is required");
    if (value != '') {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  Future<void> login(context, callback) async {
    bool deviceCheck = false;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceCheck = androidInfo.isPhysicalDevice ?? false;
      print('Is emulator: ${androidInfo.isPhysicalDevice}');
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceCheck = iosInfo.isPhysicalDevice;
      print('Is simulator: ${iosInfo.isPhysicalDevice}');
    }

    try {
      validate();
      var loginData = LoginModel(
        email: email.value ?? '',
        password: password.value ?? '',
        platform: Platform.isAndroid ? 'android' : 'iphone',
        deviceToken:
            deviceCheck ? await NotificationHelper().token() : "emulator",
      );

      ApiResponse apiResponse =
          await loginController.login(loginData.toJson(), context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        Map<dynamic, dynamic> user = apiResponse.response?.data['data'];
        //print("LoginProvider $user");

        String currentTime = DateFormat("hh:mm a").format(DateTime.now());

        UserModel userData = UserModel(
          userId: user['ID'].toString(),
          userEmail: email.value,
          userName: user['first_name'] ?? '',
          userLastName: user['last_name'] ?? '',
          userDpUrl: AppConstants.avatarDummyImage,
          password: password.value,
          fcmKey: deviceCheck ? await NotificationHelper().token() : "emulator",
          time: currentTime,
          createdAt: DateTime.now().toString(),
          isOnline: true,
        );

        await FirebaseFirestore.instance
            .collection(AppConstants.firebaseUsers)
            .doc(user['ID'].toString())
            .set(
              userData.toMap(),
            )
            .then((value) => null);
        var image =
            user['profile_img'].length > 0 ? user['profile_img'][0] ?? '' : '';

        await loginController.saveUserDataInSession(
          "${user['ID']}",
          user['first_name'] ?? '',
          user['last_name'] ?? '',
          user['user_email'] ?? '',
          user['role'] ?? '',
          image,
          user['occupation'] ?? '',
          user['bio'] ?? '',
          user['intrest'] ?? '',
          user['fcm_key'] ?? '',
        );
        callback(true, null, image != '');
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }

        callback(false, errorMessage, false);
      }
    } catch (e) {
      callback(false, e.toString().replaceAll('Exception:', ''));
    }
  }

  void runErrorCallback(ApiResponse apiResponse, callback, context) {
    String? errorMessage;
    if (apiResponse.error is String) {
      errorMessage = apiResponse.error.toString();
    } else {
      ErrorResponse errorResponse = apiResponse.error;
      errorMessage = errorResponse.errors[0];
    }
    callback(false, errorMessage, context);
  }

  validate() {
    if (email.error != null) {
      throw Exception(email.error);
    }
    if (password.error != null) {
      throw Exception(password.error);
    }
    return true;
  }

  Future<void> logout(context, callback) async {
    loginController.saveUserDataInSession(
        '', '', '', '', '', '', '', '', '', '');
    callback(true, null, context);
  }
}
