import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:hip_quest/util/ImagesResources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _logo = const SizedBox();
  bool? isActive;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logo = Image(
          image: const AssetImage(ImagesResources.logo),
          width: MediaQuery.of(context).size.width * .50,
        );
      });
    });
    Future.delayed(const Duration(milliseconds: 2500), () async {
      var prefs = await SharedPreferences.getInstance();
      if (prefs.getString(AppConstants.userId) != null &&
          prefs.getString(AppConstants.userId) != '') {
        Navigator.pushReplacementNamed(context, MainScreen.routeKey);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeKey);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: _logo,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Dr Alison Grimaldi",
              style: sansRegular.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ],
      ),
    );
  }
}
