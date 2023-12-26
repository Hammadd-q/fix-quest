import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/PrimaryButton.dart';
import 'package:hip_quest/Widgets/TextInput.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  static String routeKey = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:   ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  ImagesResources.logo,
                  width: 196,
                  height: 79,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .10),
              Text(
                "Hello,\nWelcome Back!",
                style: sansSemiBold.copyWith(
                  color:  ColorResources.black,
                  fontSize: Dimensions.fontSizeMaximum,
                ),
              ),
              const SizedBox(height: 30),
              Consumer<LoginProvider>(builder: (_, data, __) {
                return TextInput(
                  type: "email",
                  textName: "Email",
                  onChanged: data.setEmail,
                  isError: data.email.error != null,
                );
              }),
              const SizedBox(height: 15),
              Consumer<LoginProvider>(builder: (_, data, __) {
                return TextInput(
                  textName: "Password",
                  password: !_passwordVisible,
                  onChanged: data.setPassword,
                  icon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
              }),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.routeKey);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot Password?",
                    style: sansMedium.copyWith(
                      color: ColorResources.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    checkColor: ColorResources.colorSecondary,
                    fillColor: MaterialStateProperty.resolveWith((_) => ColorResources.colorPrimary),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: sansRegular.copyWith(
                              color:  ColorResources.black,
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
                  ),
                ],
              ),
              PrimaryButton(
                disabled: !isChecked,
                onPress: isChecked
                    ? () {
                        loginProvider.login(context, responseHandler);
                      }
                    : null,
                text: "Login",
              ),
              const SizedBox(height: 30),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: sansRegular.copyWith(
                              color: ColorResources.black,
                            ),
                            text: "Don't have account? ",
                          ),
                          TextSpan(
                            style: sansRegular.copyWith(
                              color: ColorResources.colorPrimary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, RegisterScreen.routeKey);
                              },
                            text: "Sign Up",
                          )
                        ],
                      ),
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



  responseHandler(isVerified, errorMessage, redirect) {
    if (!isVerified) {
      return Helpers.showErrorToast(context, errorMessage);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => redirect ? const MainScreen() : const ProfileScreen(),
      ),
      ModalRoute.withName(ProfileScreen.routeKey),
    );
  }
}
