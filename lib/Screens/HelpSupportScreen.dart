import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/MainScreen.dart';
import 'package:hip_quest/Screens/ProfileScreen.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

import '../Widgets/Widgets.dart';
import 'Screens.dart';

class HelpSupportScreen extends StatefulWidget {
  static String routeKey = '/helpsupport';

  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Help & Support'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                PrimaryButton(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebviewScreen(
                            url: contactuswebview,
                            title: 'Contact Us',
                          ),
                        ));
                  },
                  text: "Contact Us",
                ),
                const SizedBox(height: 10),
                PrimaryButton(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebviewScreen(
                            url: termandconditionwebview,
                            title: 'Terms & Conditions',
                          ),
                        ));
                  },
                  text: "Terms & Conditions",
                ),
              ],
            )),
      ),
    );
  }
}
