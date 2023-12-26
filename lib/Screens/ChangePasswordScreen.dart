import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Widgets/PrimaryButton.dart';
import 'package:hip_quest/Widgets/TextInput.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';


class ChangePasswordScreen extends StatefulWidget {
  static String routeKey = '/changepassword';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool _oldPasswordVisible = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    _oldPasswordVisible = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var changePasswordProvider =
        Provider.of<ChangePasswordProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
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
                "Change,\nPassword?",
                style: sansSemiBold.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeMaximum,
                ),
              ),
              const SizedBox(height: 15),
              Consumer<ChangePasswordProvider>(builder: (_, data, __) {
                return TextInput(
                  textName: "Old Password",
                  password: !_oldPasswordVisible,
                  controller: oldPasswordController,
                  onChanged: data.setOldPassword,
                  isError: data.oldPassword.error != null,
                  icon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _oldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorResources.colorPrimary,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _oldPasswordVisible = !_oldPasswordVisible;
                      });
                    },
                  ),
                );
              }),
              const SizedBox(height: 15),
              Consumer<ChangePasswordProvider>(builder: (_, data, __) {
                return TextInput(
                  textName: "New Password",
                  password: !_passwordVisible,
                  controller: newPasswordController,
                  onChanged: data.setNewPassword,
                  isError: data.newPassword.error != null,
                  icon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorResources.colorPrimary,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                );
              }),
              const SizedBox(height: 30),
              PrimaryButton(
                onPress: () {
                  changePasswordProvider.changePassword(
                      context, responseHandler);
                },
                text: "Save",
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
    oldPasswordController.clear();
    newPasswordController.clear();
    Helpers.showSuccessToast(context, message);
    //Navigator.pop(context);
  }
}
