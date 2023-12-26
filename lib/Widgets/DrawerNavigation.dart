import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/LoginScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/DrawerItem.dart';
import 'package:hip_quest/Widgets/settings.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/ImagesResources.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  String? currentUserID;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      currentUserID = prefs.getString(AppConstants.userId) ?? "";
      currentUserEmail = prefs.getString(AppConstants.userEmail) ?? "";
      print("currentUserID $currentUserID");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        left: false,
        right: false,
        child: Container(
          color: ColorResources.colorPrimary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27),
                      ),
                      color: ColorResources.white),
                  child: Image.asset(ImagesResources.logo),
                ),
                const SizedBox(height: 20),
                DrawerItem(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewScreen(
                              url: eventwebview,
                              title: 'Events',
                            ),
                          ));
                    },
                    icon: Icons.today_outlined,
                    title: 'Events'),

                // DrawerItem(
                //     onPress: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const WebviewScreen(
                //               url: 'https://dralisongrimaldi.com/products/',
                //               title: 'Products',
                //             ),
                //           ));
                //     },
                //     icon: Icons.inventory_2_outlined,
                //     title: 'Products'),
                DrawerItem(
                    onPress: () {
                      Navigator.pushNamed(context, FreeResourceScreen.routeKey);
                    },
                    icon: Icons.topic_outlined,
                    title: 'Free Resources'),
                // DrawerItem(
                //     onPress: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const WebviewScreen(
                //               url: 'https://dralisongrimaldi.com/prices/',
                //               title: 'Prices',
                //             ),
                //           ));

                //     }, icon: Icons.paid_outlined, title: 'Prices'),
                // DrawerItem(
                //     onPress: () {
                //       Navigator.pushNamed(context, ProfileScreen.routeKey);

                //     },
                //     icon: Icons.account_circle_outlined,
                //     title: 'My Account'),
                DrawerItem(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const settingscreen(),
                          ));
                    },
                    icon: Icons.settings,
                    title: 'Settings'),
                // DrawerItem(
                //     onPress: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => NotificationScreen(
                //                 currentUserEmail: currentUserEmail),
                //           ));
                //     },
                //     icon: Icons.notifications,
                //     title: 'Notifications'),

                DrawerItem(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewScreen(
                              url: privacypolicywebview,
                              title: 'Privacy & Security',
                            ),
                          ));
                    },
                    icon: Icons.lock,
                    title: 'Privacy & Security'),
                DrawerItem(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebviewScreen(
                              url: aboutwebview,
                              title: 'About',
                            ),
                          ));
                    },
                    icon: Icons.info,
                    title: 'About'),
                DrawerItem(
                    onPress: () {
                      Navigator.pushNamed(context, HelpSupportScreen.routeKey);
                    },
                    icon: Icons.support_agent_outlined,
                    title: 'Help & Support'),
                DrawerItem(
                  onPress: () {
                    FirebaseFirestore.instance
                        .collection(AppConstants.firebaseUsers)
                        .doc(currentUserID)
                        .update({"isOnline": false});

                    Provider.of<LoginProvider>(context, listen: false)
                        .logout(context, (_, __, ___) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeKey, (route) => false);
                    });
                  },
                  icon: Icons.exit_to_app_outlined,
                  title: 'Logout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
