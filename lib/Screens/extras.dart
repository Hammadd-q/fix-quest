import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Forumscreen.dart';
import 'package:hip_quest/Screens/FreePdfScreen.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Screens/membermeetingscreen.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:hip_quest/util/ImagesResources.dart';

class extrasscreen extends StatefulWidget {
  const extrasscreen({Key? key}) : super(key: key);

  @override
  State<extrasscreen> createState() => _extrasscreenState();
}

class _extrasscreenState extends State<extrasscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Hip Academy Extras'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hip Academy Extras",
                  style: sansSemiBold.copyWith(
                    color: ColorResources.black,
                    fontSize: Dimensions.fontSizeMaximum,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(8),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  children: [
                    DashboardBox(
                      title: "Free Download PDF's",
                      icon: ImagesResources.pdf,
                      onPress: () {
                        Navigator.pushNamed(context, FreePdfScreen.routeKey);
                      },
                    ),
                    DashboardBox(
                      title: "Knowledge Quiz Center",
                      icon: ImagesResources.quizcenter,
                      onPress: () {
                        Navigator.pushNamed(context, QuizInfoScreen.routeKey);
                      },
                    ),
                    DashboardBox(
                      title: "Member Meetings",
                      icon: ImagesResources.meetingrecord,
                      onPress: () {
                        Navigator.pushNamed(
                            context, MemberMeetingScreen.routeKey);
                      },
                    ),
                    DashboardBox(
                      title: "Forums",
                      icon: ImagesResources.blogs,
                      onPress: () {
                        Navigator.pushNamed(context, ForumScreen.routeKey);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
