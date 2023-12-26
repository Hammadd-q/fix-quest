import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hip_quest/Screens/Forumscreen.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Screens/ebook.dart';
import 'package:hip_quest/Screens/extras.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/Screens/membermeetingscreen.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:http/http.dart' as http;

class MemberHomeTab extends StatefulWidget {
  const MemberHomeTab({Key? key}) : super(key: key);

  @override
  State<MemberHomeTab> createState() => _MemberHomeTabState();
}

class _MemberHomeTabState extends State<MemberHomeTab> {
  bool isCustomer = false;
  bool isloading = true;
  String memberTitle = "Access your\nMembership and\nUseful Clinical Resources";
  late String title;

  Future<void> fetchuserstatus() async {
    final apiUrl = '${AppConstants.baseUrl}is_user_member/?user_id=$userid';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData;
      print("the id subscription for$userid is ${data}");
      if (this.mounted) {
        setState(() {
          isdatafetched = true;
          issubscribed = data;
          isloading = false;
        });
      }
    } else {
      throw Exception('Failed to load meeting data');
    }
  }

  @override
  void initState() {
    if (isdatafetched == false) {
      fetchuserstatus();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isdatafetched == false)
        ? loading()
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      memberTitle,
                      style: sansSemiBold.copyWith(
                        color: ColorResources.black,
                        fontSize: Dimensions.fontSizeMaximum,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                (issubscribed == true)
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .58,
                        child: GridView.count(
                          shrinkWrap: false,
                          padding: const EdgeInsets.all(12.0),
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          children: [
                            DashboardBox(
                              title: "Blogs",
                              icon: ImagesResources.blogs,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, BlogScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Events",
                              icon: ImagesResources.events,
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebviewScreen(
                                        url: eventwebview,
                                        title: 'Events',
                                      ),
                                    ));
                                // Navigator.pushNamed(
                                //     context, EventScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Courses",
                              icon: ImagesResources.hipxtra,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, CoursesScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "eBooks",
                              icon: ImagesResources.menu,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, BookListScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Video Library",
                              icon: ImagesResources.meetingrecord,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, VideoLibraryScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Free Resources",
                              icon: ImagesResources.freeresoursces,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, FreeResourceScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Hip Academy Extras",
                              icon: ImagesResources.skeleton,
                              onPress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const extrasscreen(),
                                    ));
                              },
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * .58,
                        child: GridView.count(
                          shrinkWrap: false,
                          padding: const EdgeInsets.all(12.0),
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.2,
                          children: [
                            DashboardBox(
                              title: "Blogs",
                              icon: ImagesResources.blogs,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, BlogScreen.routeKey);
                              },
                            ),
                            DashboardBox(
                              title: "Events",
                              icon: ImagesResources.events,
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
                            ),
                            DashboardBox(
                              title: "Free Resources",
                              icon: ImagesResources.freeresoursces,
                              onPress: () {
                                Navigator.pushNamed(
                                    context, FreeResourceScreen.routeKey);
                              },
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 40),
              ],
            ),
          );
  }
}
