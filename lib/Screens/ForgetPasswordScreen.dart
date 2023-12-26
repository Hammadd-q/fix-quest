import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Widgets/PrimaryButton.dart';
import 'package:hip_quest/Widgets/TextInput.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeKey = '/forget';

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var forgotProvider = Provider.of<ForgotProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          // padding:
          // EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  ImagesResources.logo,
                  width: 196,
                  height: 79,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .15),
              Text(
                "Forgot,\nPassword?",
                style: sansSemiBold.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeMaximum,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Don't worry! It happens. Please enter the address\nassociated with your account.",
                style: sansSemiBold.copyWith(
                  color:ColorResources.black,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeSmall,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 15),
              Consumer<ForgotProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      type: "email",
                      textName: "Enter your email",
                      onChanged: data.setEmail,
                      isError: data.email.error != null,
                    );
                  }
              ),

              const SizedBox(height: 30),
              PrimaryButton(
                onPress: () {
                  forgotProvider.forgotPassword(context, responseHandler);
                },
                text: "Submit",
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  responseHandler(message, isVerified, errorMessage) {
    if (!isVerified) {
      return Helpers.showErrorToast(context, errorMessage);
    }
    Helpers.showSuccessToast(context, message);
    Navigator.pop(context);
  }
}
