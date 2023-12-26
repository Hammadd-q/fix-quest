import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/controller/Controllers.dart';
import 'package:hip_quest/data/model/ValidationItem.dart';
import 'package:hip_quest/data/model/body/RegisterModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/helper/NotificationHelper.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterController registerController;
  final LoginController loginController;

  RegisterProvider({required this.registerController, required this.loginController});

  ValidationItem _username = ValidationItem(null, "Username is required");
  ValidationItem _firstName = ValidationItem(null, "First Name Required");
  ValidationItem _lastName = ValidationItem(null, "Last Name Required");
  ValidationItem _email = ValidationItem(null, "Email is Required");
  ValidationItem _password = ValidationItem(null, "Password is Required");
  ValidationItem _confirmPassword = ValidationItem(null, "Confirm Password is Required");

  ValidationItem get username => _username;

  ValidationItem get firstName => _firstName;

  ValidationItem get lastName => _lastName;

  ValidationItem get email => _email;

  ValidationItem get password => _password;

  ValidationItem get confirmPassword => _confirmPassword;

  void setUsername(String value) {
    _username = ValidationItem(null, "Username is required");
    if (value != '') {
      _username = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = ValidationItem(null, "First Name is not valid");

    if (value != '') {
      _firstName = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = ValidationItem(null, "Last Name is not valid");
    if (value != '') {
      _lastName = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setEmail(String value) {
    _email = ValidationItem(null, "Email is not valid");
    if (Helpers.checkEmail(value)) {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setPassword(String value) {
    _password = ValidationItem(null, "Password is not valid");
    if (value != '') {
      _password = ValidationItem(value, null);
    }
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = ValidationItem(null, "Confirm Password is not valid");
    if (value != '') {
      _confirmPassword = ValidationItem(value, null);
    }
    notifyListeners();
  }

  Future<void> register(context, callback) async {

    bool? deviceCheck;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo  = await deviceInfo.androidInfo;
      deviceCheck = androidInfo.isPhysicalDevice;
      print('Is emulator: ${androidInfo.isPhysicalDevice}');
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceCheck = iosInfo.isPhysicalDevice;
      print('Is simulator: ${iosInfo.isPhysicalDevice}');
    }

    try {
      validate();
      var registerData = RegisterModel();
      registerData.username = username.value;
      registerData.firstName = firstName.value;
      registerData.lastName = lastName.value;
      registerData.email = email.value;
      registerData.password = password.value;
      registerData.platform = Platform.isAndroid ? 'android' : 'iphone';
      registerData.deviceToken = deviceCheck? await NotificationHelper().token() : "emulator";




      ApiResponse apiResponse = await registerController.register(registerData.toJson(), context);
      if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        callback(apiResponse.response?.data['message'], true, null);
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();

        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];

        }

        callback(null, false, errorMessage);
      }
    } catch (e) {
      callback(null, false, e.toString().replaceAll('Exception:', ''));
    }
  }

  validate() {
    if (username.error != null) {
      throw Exception(username.error);
    }
    if (firstName.error != null) {
      throw Exception(firstName.error);
    }
    if (lastName.error != null) {
      throw Exception(lastName.error);
    }
    if (email.error != null) {
      throw Exception(email.error);
    }
    if (password.error != null) {
      throw Exception(password.error);
    }
    if (confirmPassword.error != null) {
      throw Exception(confirmPassword.error);
    }
    if (confirmPassword.value != password.value) {
      throw Exception("Confirm password doesn't match");
    }
    return true;
  }
}
