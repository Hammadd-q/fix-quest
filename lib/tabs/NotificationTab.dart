import 'package:flutter/material.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/Screens.dart';
import '../util/AppConstants.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      currentUserEmail = userid;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  color: ColorResources.white,
                  shape: BoxShape.circle,
                ),
                child: Stack(children: [
                  Align(
                      child: SizedBox(
                    child: Container(
                      width: 66.0,
                      height: 80.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(ImagesResources.bell)),
                      ),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor: ColorResources.colorPrimary,
                          radius: 15.0,
                        ),
                      ),
                    ),
                  )),
                ]),
              ),
              const SizedBox(height: 15),

              Text("Ensure you don't miss out!",
                  style: sansSemiBold.copyWith(
                      color: ColorResources.colorPrimary,
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w500)),

              const SizedBox(height: 15),
              Text(
                "Turn on notifications to be the first to\nknow when new resources get posted. ",
                style: sansSemiBold.copyWith(
                    color: ColorResources.black,
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 40),
              // Rectangle 671
              GestureDetector(
                onTap: (() => {
                      // Navigator.pushNamed(context, NotificationScreen.routeKey)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(
                                currentUserEmail: currentUserEmail),
                          ))
                    }),
                child: Container(
                    width: 343,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorResources.colorPrimary),
                    child: Center(
                        child: Text(
                      "Accept",
                      style: sansSemiBold.copyWith(
                          color: ColorResources.white,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400),
                    ))),
              ),

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                    child: // Skip
                        GestureDetector(
                  onTap: (() => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(
                                  currentUserEmail: currentUserEmail),
                            ))
                      }),
                  child: Text(
                    "Skip",
                    style: sansSemiBold.copyWith(
                      color: ColorResources.colorPrimary,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
