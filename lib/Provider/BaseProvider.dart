import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/LoginScreen.dart';
import 'package:hip_quest/data/controller/Controllers.dart';
import 'package:hip_quest/helper/Helpers.dart';

class BaseProvider extends ChangeNotifier {
  logout(LoginController loginController, context) {
    loginController.saveUserDataInSession('', '', '', '', '', '', '', '', '','');
    Helpers.showErrorToast(context, "You have logged in another device please login again");
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeKey, (route) => false);
  }
}
