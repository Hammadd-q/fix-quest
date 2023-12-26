import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/FreePdfProvider.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

import '../helper/Helpers.dart';

class FreePdfScreen extends StatefulWidget {
  static String routeKey = '/freepdf';

  const FreePdfScreen({Key? key}) : super(key: key);

  @override
  State<FreePdfScreen> createState() => _FreePdfScreenState();
}

class _FreePdfScreenState extends State<FreePdfScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FreePdfProvider>(context, listen: false).getFreeResource(context,responseHandler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Free Download PDFs'),
      body:
      SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<FreePdfProvider>(
                builder: (_, data, __) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.freeResources.length,
                    itemBuilder: (context, index) {
                      return
                        FreePdf(freeResourceModel: data.freeResources[index]);
                    },
                  );
                }
            ),
          )),
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
