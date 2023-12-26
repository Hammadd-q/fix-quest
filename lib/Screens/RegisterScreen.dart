import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/ProfileScreen.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static String routeKey = '/register';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  bool isChecked1 = false;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var registerProvider = Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(

          // EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Sign Up",
                style: sansSemiBold.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeMaximum,
                ),
              ),
              const SizedBox(height: 20),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      textName: "Username",
                      onChanged: data.setUsername,
                      isError: data.username.error != null,
                    );
                  }
              ),
              const SizedBox(height: 12),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      type: "email",
                      textName: "Email",
                      onChanged: data.setEmail,
                      isError: data.email.error != null,
                    );
                  }
              ),
              const SizedBox(height: 12),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      textName: "First Name",
                      onChanged: data.setFirstName,
                      isError: data.firstName.error != null,
                    );
                  }
              ),
              const SizedBox(height: 12),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      textName: "Last Name",
                      onChanged: data.setLastName,
                      isError: data.lastName.error != null,
                    );
                  }
              ),

              const SizedBox(height: 12),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return TextInput(
                      textName: "Password",
                      password: !_passwordVisible,
                      onChanged: registerProvider.setPassword,
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
                      isError: data.password.error != null,
                    );
                  }
              ),

              const SizedBox(height: 12),
              Consumer<RegisterProvider>(
                  builder: (_, data, __) {
                    return
                      TextInput(
                        textName: "Confirm Password",
                        password: !_confirmPasswordVisible,
                        onChanged: registerProvider.setConfirmPassword,
                        icon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: ColorResources.colorPrimary,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                        ),
                        isError: data.confirmPassword.error != null,
                      );
                  }
              ),

              const SizedBox(height: 12),

              //! city and country don`t want right now
              // SelectInput(
              //   textName: "Select City",
              //   listItem: const ["Karachi", "Lahore", "Islamabad"],
              //   onChange: (_) {},
              // ),
              // const SizedBox(height: 12),
              // SelectInput(
              //   textName: "Select Country",
              //   listItem: const ["Pakistan", "UAE", "KSA"],
              //   onChange: (_) {},
              // ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: ColorResources.colorSecondary,
                      fillColor: MaterialStateProperty.resolveWith((_) => ColorResources.colorPrimary),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Are you a Health Professional?",
                    style: sansRegular.copyWith(
                      color: ColorResources.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: ColorResources.colorSecondary,
                      fillColor: MaterialStateProperty.resolveWith((_) => ColorResources.colorPrimary),
                      value: isChecked1,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked1 = value!;
                        });
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: sansRegular.copyWith(
                            color: ColorResources.black,
                          ),
                          text: "Do you agree with our ",
                        ),
                        TextSpan(
                          style: sansRegular.copyWith(
                            color: ColorResources.colorPrimary,
                          ),
                          text: "Terms and Conditions?",
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                disabled: !isChecked || !isChecked1,
                onPress: isChecked && isChecked1
                    ? () {
                        registerProvider.register(context, responseHandler);
                      }
                    : null,
                text: "Sign Up",
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          style: sansRegular.copyWith(
                            color:ColorResources.black,
                          ),
                          text: "If you already have account? ",
                        ),
                        TextSpan(
                          style: sansRegular.copyWith(
                            color: ColorResources.colorPrimary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                          text: "Login",
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
