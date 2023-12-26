import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hip_quest/Screens/Forumscreen.dart';
import 'package:hip_quest/Screens/QuizScreen.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Screens/ebook.dart';
import 'package:hip_quest/Screens/membermeetingscreen.dart';
import 'package:hip_quest/helper/NetworkInfo.dart';
import 'package:hip_quest/util/Utils.dart';

class HipQuest extends StatefulWidget {
  const HipQuest({
    Key? key,
  }) : super(key: key);

  @override
  State<HipQuest> createState() => _HipQuestState();
}

class _HipQuestState extends State<HipQuest> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      NetworkInfo.checkConnectivity(navigatorKey.currentContext);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          ColorResources.colorPrimary, //or set color with: Color(0xFF0000FF)
    ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const SplashScreen(),
        routes: {
          LoginScreen.routeKey: (_) => const LoginScreen(),
          RegisterScreen.routeKey: (_) => const RegisterScreen(),
          ForgetPasswordScreen.routeKey: (_) => const ForgetPasswordScreen(),
          ChangePasswordScreen.routeKey: (_) => const ChangePasswordScreen(),
          ProfileScreen.routeKey: (_) => const ProfileScreen(),
          MainScreen.routeKey: (_) => const MainScreen(),
          EbookScreen.routeKey: (_) => const EbookScreen(),
          EventScreen.routeKey: (_) => const EventScreen(),
          BlogScreen.routeKey: (_) => const BlogScreen(),
          GroupChatRoomScreen.routeKey: (_) => const GroupChatRoomScreen(),
          CoursesScreen.routeKey: (_) => const CoursesScreen(),
          FavouriteScreen.routeKey: (_) => const FavouriteScreen(),
          NewsFeedScreen.routeKey: (_) => const NewsFeedScreen(),
          VideoLibraryScreen.routeKey: (_) => VideoLibraryScreen(),
          FreeResourceScreen.routeKey: (_) => const FreeResourceScreen(),
          // QuizInfoScreen.routeKey: (_) => const QuizInfoScreen(),
          FreePdfScreen.routeKey: (_) => const FreePdfScreen(),
          HelpSupportScreen.routeKey: (_) => const HelpSupportScreen(),
          MemberMeetingScreen.routeKey: (_) => const MemberMeetingScreen(),
          ForumScreen.routeKey: (_) => ForumScreen(),
          BookListScreen.routeKey: (_) => BookListScreen(),
        },
      ),
    );
  }
}
