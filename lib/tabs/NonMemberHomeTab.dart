import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/Utils.dart';

class NonMemberHomeTab extends StatefulWidget {
  const NonMemberHomeTab({Key? key}) : super(key: key);

  @override
  State<NonMemberHomeTab> createState() => _NonMemberHomeTabState();
}

class _NonMemberHomeTabState extends State<NonMemberHomeTab> {
  String nonMemberTitle = "Explore a Wide\nRange of Free\nClinical Resources";
  late String title;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                nonMemberTitle,
                style: sansSemiBold.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeMaximum,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
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
                    Navigator.pushNamed(context, BlogScreen.routeKey);
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
                    Navigator.pushNamed(context, FreeResourceScreen.routeKey);
                  },
                ),
                DashboardBox(
                  title: "Paid Resources",
                  icon: ImagesResources.skeleton,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WebviewScreen(
                          url: 'https://dralisongrimaldi.com/hip-academy/',
                          title: 'Paid Resources',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
