import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/HipQuest.dart';
import 'package:hip_quest/AppContainer.dart' as di;
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/helper/NotificationHelper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

Future onesignalInitialise() async {
  final String oneSignalAppId = "69b0137a-1dca-4fd2-ab3a-75532296d464";
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(oneSignalAppId);
  OneSignal.Notifications.requestPermission(true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().configure();
  await Firebase.initializeApp();
  await di.init();

  onesignalInitialise();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<LoginProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<RegisterProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<ForgotProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<UserInfoProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<BlogProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<EventProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<VideoLibraryProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<ChatUserProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<EBookProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<CourseProvider>()),
        ChangeNotifierProvider(
            create: (context) => di.sl<ChangePasswordProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<FreePdfProvider>()),
      ],
      child: const HipQuest(),
    ),
  );
}
