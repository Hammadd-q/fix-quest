import 'package:flutter/material.dart';
import 'package:hip_quest/data/controller/Controllers.dart';
import 'package:hip_quest/data/model/ValidationItem.dart';
import 'package:hip_quest/data/model/body/ChangePasswordModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final ChangePasswordController changePasswordController;

  ChangePasswordProvider({required this.changePasswordController});

  ValidationItem _oldPassword =
      ValidationItem(null, "Old password is required");
  ValidationItem _newPassword =
      ValidationItem(null, "New password is required");

  ValidationItem get oldPassword => _oldPassword;

  ValidationItem get newPassword => _newPassword;

  void setOldPassword(String value) {
    _oldPassword = ValidationItem(null, "Old password is required");
    if (value != '') {
      _oldPassword = ValidationItem(value, null);
    }
    notifyListeners();

  }

  void setNewPassword(String value) {
    _newPassword = ValidationItem(null, "New password is required");
    if (value != '') {
      _newPassword = ValidationItem(value, null);
    }
    notifyListeners();
  }

  Future<void> changePassword(context, callback) async {
    try {
      validate();
      var changePasswordModel = ChangePasswordModel();
      var prefs = await SharedPreferences.getInstance();
      changePasswordModel.email = prefs.getString(AppConstants.userEmail) ?? "";
      changePasswordModel.oldPassword = oldPassword.value;
      changePasswordModel.newPassword = newPassword.value;

      ApiResponse apiResponse = await changePasswordController.changePassword(
          changePasswordModel.toJson(), context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
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

        //callback(null, false, "No user found associated with this email");
      }
    } catch (e) {
      callback(null, false, e.toString().replaceAll('Exception:', ''));
    }
  }

  validate() {
    if (oldPassword.error != null) {
      throw Exception(oldPassword.error);
    }
    if (newPassword.error != null) {
      throw Exception(newPassword.error);
    }
    return true;
  }
}
