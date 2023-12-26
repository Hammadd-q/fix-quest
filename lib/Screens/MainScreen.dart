import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/tabs/ConversationTab.dart';
import 'package:hip_quest/tabs/Tabs.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/AppConstants.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  static String routeKey = '/main';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  PageController _pageController = PageController();
  int _selectedTab = 0;
  Map<int, String?> tabTitles = {
    0: null,
    1: "Message",
    2: "Quiz",
  };

  bool isCustomer = true;
  String? profileImage;
  String? currentUserID;
  String? currentUserEmail;
  bool isloading = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
    if (state == AppLifecycleState.resumed) {
      FirebaseFirestore.instance
          .collection(AppConstants.firebaseUsers)
          .doc(currentUserID)
          .update({"isOnline": true});
    } else {
      FirebaseFirestore.instance
          .collection(AppConstants.firebaseUsers)
          .doc(currentUserID)
          .update({"isOnline": false});
    }
  }

  @override
  void initState() {
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var prefs = await SharedPreferences.getInstance();
      isCustomer = prefs.getString(AppConstants.role) == 'customer';
      setState(() {
        userid = prefs.getString(AppConstants.userId)!;
        currentUserID = prefs.getString(AppConstants.userId) ?? "";
        currentUserEmail = prefs.getString(AppConstants.userEmail) ?? "";
        profileImage = prefs.getString(AppConstants.profileImage);
        isloading = false;
      });

      print("currentUserID $userid");
      print("currentUserEmail $currentUserEmail");
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isloading == true)
        ? Container(
            color: Colors.white,
            child: Column(
              children: [
                Spacer(),
                Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.colorPrimary,
                  ),
                ),
                Spacer()
              ],
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorResources.colorSecondary,
            drawer: const DrawerNavigation(),
            appBar: (_selectedTab == 2)
                ? null
                : GlobalAppBar(
                    backButton: false,
                    title: tabTitles[_selectedTab],
                    avatar: _selectedTab == 0,
                    profileImage: profileImage,
                  ),
            body: SafeArea(
              bottom: false,
              left: false,
              right: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int num) {
                        setState(() {
                          _selectedTab = num;
                        });
                      },
                      children: [
                        const MemberHomeTab(),
                        const ConversationTab(),
                        const QuizInfoScreen(
                          appbar: false,
                        ),
                      ],
                    ),
                  ),
                  BottomTabs(
                    selectedTab: _selectedTab,
                    tabPressed: (int num) {
                      _pageController.animateToPage(
                        num,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }
}
