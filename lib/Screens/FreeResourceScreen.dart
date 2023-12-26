import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/Utils.dart';

import '../Widgets/GlobalAppBar.dart';

class FreeResourceScreen extends StatefulWidget {
  static String routeKey = '/freeresource';

  const FreeResourceScreen({Key? key}) : super(key: key);

  @override
  State<FreeResourceScreen> createState() => _FreeResourceScreenState();
}

class _FreeResourceScreenState extends State<FreeResourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Free Resources'),
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
                  "Free Resources",
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
                      title: "Talking Hips with Dr. Ali",
                      icon: ImagesResources.menu,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebviewScreen(
                                url: draliwebview,
                                title: 'Talking Hips with Dr. Ali',
                              ),
                            ));
                      },
                    ),
                    // DashboardBox(
                    //   title: "Blogs",
                    //   icon: ImagesResources.writeblogs,
                    //   onPress: () {
                    //     Navigator.pushNamed(context, BlogScreen.routeKey);
                    //   },
                    // ),
                    // DashboardBox(
                    //   title: "Publication",
                    //   icon: ImagesResources.publication,
                    //   onPress: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const WebviewScreen(
                    //             url:
                    //                 'https://dralisongrimaldi.com/publications/',
                    //             title: 'Publication',
                    //           ),
                    //         ));
                    //   },
                    // ),
                    // DashboardBox(
                    //   title: "Podcasts",
                    //   icon: ImagesResources.podcast,
                    //   onPress: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const WebviewScreen(
                    //             url: 'https://dralisongrimaldi.com/podcasts/',
                    //             title: 'Podcasts',
                    //           ),
                    //         ));
                    //   },
                    // ),

                    // DashboardBox(
                    //   title: "Hip Academy Extras",
                    //   icon: ImagesResources.skeleton,
                    //   onPress: () {},
                    // ),
                    // DashboardBox(
                    //   title: "Noticeboard & Forum",
                    //   icon: ImagesResources.noticeboard,
                    //   onPress: () {},
                    // ),
                    // DashboardBox(
                    //   title: "Member Meetings",
                    //   icon: ImagesResources.membermeeting,
                    //   onPress: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const WebviewScreen(
                    //             url:
                    //                 'https://dralisongrimaldi.com/hip-academy-meetings/',
                    //             title: 'Member Meetings',
                    //           ),
                    //         ));
                    //   },
                    // ),
                    DashboardBox(
                      title: "Knowledge Quiz Centre",
                      icon: ImagesResources.quizcenter,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizInfoScreen(
                                appbar: true,
                              ),
                            ));
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
