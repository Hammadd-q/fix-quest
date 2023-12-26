import 'package:flutter/material.dart';
import 'package:hip_quest/data/controller/ForgotController.dart';
import 'package:hip_quest/data/model/ValidationItem.dart';
import 'package:hip_quest/data/model/body/ForgotModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:hip_quest/helper/Helpers.dart';

class ForgotProvider extends ChangeNotifier {
  final ForgotController forgotController;

  ForgotProvider({required this.forgotController});

  ValidationItem _email = ValidationItem(null, "Email is not valid");

  ValidationItem get email => _email;

  void setEmail(String value) {
    _email = ValidationItem(null, "Email is not valid");
    if (Helpers.checkEmail(value)) {
      _email = ValidationItem(value, null);
    }
    notifyListeners();
  }

  Future<void> forgotPassword(context, callback) async {
    try {
      validate();
      var forgotModel = ForgotModel(
        email: email.value ?? '',
      );
      ApiResponse apiResponse = await forgotController.forgot(forgotModel.toJson(), context);
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
       // callback(null, false, "No user found associated with this email");
      }
    } catch (e) {
      callback(null, false, e.toString().replaceAll('Exception:', ''));
    }
  }

  validate() {
    if (email.error != null) {
      throw Exception(email.error);
    }
    return true;
  }
}
