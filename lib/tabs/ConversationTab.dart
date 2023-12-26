import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/tabs/Tabs.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/SearchChatUsers.dart';
import '../data/model/user_model.dart';
import '../util/AppConstants.dart';

const double borderRadius = 8.5;

class ConversationTab extends StatefulWidget {
  const ConversationTab({Key? key}) : super(key: key);

  @override
  State<ConversationTab> createState() => _ConversationTabState();
}

class _ConversationTabState extends State<ConversationTab> {
  PageController _pageController = PageController();

  int activePageIndex = 0;

  UserModel? userModel;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    _pageController = PageController();
  }

  void getCurrentUser() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString(AppConstants.userId) ?? "";

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection(AppConstants.firebaseUsers)
          .doc(userId)
          .get();
      userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);
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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
                      //   child: _menuBar(context),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: (activePageIndex == 0)
                              ? BoxDecoration(
                                  color:
                                      const Color(0xffd7536d).withOpacity(0.8),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(borderRadius)),
                                )
                              : null,
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                        ),
                      ),
                      Expanded(child: ChatTab(userModel: userModel)),
                      // Expanded(
                      //   flex: 2,
                      //   child: PageView(
                      //     controller: _pageController,
                      //     physics: const ClampingScrollPhysics(),
                      //     onPageChanged: (int i) {
                      //       FocusScope.of(context).requestFocus(FocusNode());
                      //       setState(() {
                      //         activePageIndex = i;
                      //       });
                      //     },
                      //     children: <Widget>[
                      //       ChatTab(userModel: userModel),
                      //       const GroupChatTab()
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: (activePageIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchChatUsers(userModel: userModel),
                    ),
                  );
                },
                backgroundColor: ColorResources.colorPrimary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : null);
  }

  Widget _menuBar(BuildContext context) {
    return Container(
      width: 350.0,
      height: 45.0,
      decoration: const BoxDecoration(
        color: ColorResources.colorSecondary,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: InkWell(
              borderRadius:
                  const BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onPlaceBidButtonPress,
              child: Container(
                width: 172,
                height: 45,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 0)
                    ? BoxDecoration(
                        color: const Color(0xffd7536d).withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(borderRadius)),
                      )
                    : null,
                child: Text(
                  "Chat",
                  style: (activePageIndex == 0)
                      ? const TextStyle(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeSmall)
                      : const TextStyle(
                          color: ColorResources.black,
                          fontSize: Dimensions.fontSizeSmall),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius:
                  const BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onBuyNowButtonPress,
              child: Container(
                width: 172,
                height: 45,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 1)
                    ? BoxDecoration(
                        color: const Color(0xffd7536d).withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(borderRadius)),
                      )
                    : null,
                child: Text(
                  "Groups",
                  style: (activePageIndex == 1)
                      ? const TextStyle(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeSmall)
                      : const TextStyle(
                          color: ColorResources.black,
                          fontSize: Dimensions.fontSizeSmall),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
