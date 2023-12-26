import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';

class Helpers {
  static showErrorToast(context, message) {
    _showToast(context, message, true);
  }

  static showSuccessToast(context, message) {
    _showToast(context, message, false);
  }

  static showLoader(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                    color: ColorResources.colorPrimary),
                const SizedBox(height: 20.0),
                Text(
                  "Please Wait",
                  style: sansSemiBold.copyWith(
                    color: ColorResources.colorPrimary,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static dismissLoader(context) {
    Navigator.pop(context);
  }

  static _showToast(context, message, bool error) {
    return showToast(
      message,
      context: context,
      position: StyledToastPosition.top,
      textStyle: sansMedium.copyWith(
        color: ColorResources.white,
      ),
      backgroundColor:
          error ? ColorResources.errorStatus : ColorResources.successStatus,
      fullWidth: true,
      animDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 3),
      animationBuilder: (
        BuildContext context,
        AnimationController controller,
        Duration duration,
        Widget child,
      ) {
        return SlideTransition(
          position: getAnimation<Offset>(
            const Offset(3.0, 0.0),
            const Offset(0, 0),
            controller,
            curve: Curves.bounceIn,
          ),
          child: child,
        );
      },
      reverseAnimBuilder: (
        BuildContext context,
        AnimationController controller,
        Duration duration,
        Widget child,
      ) {
        return SlideTransition(
          position: getAnimation<Offset>(
            const Offset(0.0, 0.0),
            const Offset(-3.0, 0),
            controller,
            curve: Curves.bounceOut,
          ),
          child: child,
        );
      },
    );
  }

  static bool checkEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String getInitials(String name) {
    return name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(2).join()
        : '';
  }

  static bool checkCnic(cnic) {
    return RegExp(r"\d{5}-\d{7}-\d").hasMatch(cnic);
  }

  static showSnackBar(context, String message, Color color) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: color);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlertDialog(
      BuildContext context, String title, String description) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
