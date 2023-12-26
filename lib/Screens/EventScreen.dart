import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/WebviewScreens.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

import '../helper/Helpers.dart';

class EventScreen extends StatefulWidget {
  static String routeKey = '/event';

  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false)
          .getEvents(context, responseHandler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Events'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 25),
              WebviewScreen(title: "Events", url: eventwebview)
            ],
          ),
        ),
      ),
    );
  }

  responseHandler(message, isVerified, errorMessage) {
    if (!isVerified) {
      return Helpers.showErrorToast(context, errorMessage);
      // return Helpers.showAlertDialog(context, "Course Alert", errorMessage);
    }
    Helpers.showSuccessToast(context, message);
    Navigator.pop(context);
  }
}
