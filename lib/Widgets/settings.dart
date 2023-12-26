import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/ChangePasswordScreen.dart';
import 'package:hip_quest/Screens/Forumscreen.dart';
import 'package:hip_quest/Screens/FreePdfScreen.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Screens/membermeetingscreen.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:hip_quest/util/ImagesResources.dart';

class settingscreen extends StatefulWidget {
  const settingscreen({Key? key}) : super(key: key);

  @override
  State<settingscreen> createState() => _settingscreenState();
}

class _settingscreenState extends State<settingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    color: ColorResources.colorPrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Change Password",
                        textAlign: TextAlign.center,
                        style: sansSemiBold.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    color: ColorResources.colorPrimary,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Profile Update",
                        textAlign: TextAlign.center,
                        style: sansSemiBold.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
