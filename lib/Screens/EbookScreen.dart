import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/EBookProvider.dart';
import 'package:hip_quest/Widgets/GlobalAppBar.dart';
import 'package:hip_quest/Widgets/TextInput.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:provider/provider.dart';

import '../helper/Helpers.dart';

class EbookScreen extends StatefulWidget {
  static String routeKey = '/ebooks';

  const EbookScreen({Key? key}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EBookProvider>(context, listen: false).getEbooks(context,responseHandler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'eBooks'),
      body:
      SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextInput(
                textName: "Search",
                onChanged: Provider.of<EBookProvider>(context, listen: false).search,
                icon: const Icon(
                  Icons.search,
                  color: ColorResources.colorPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Consumer<EBookProvider>(
                builder: (_, data, __) {
                  return Expanded(
                    child:
                    GridView.count(
                      childAspectRatio: (MediaQuery.of(context).size.width / 3.5) / (MediaQuery.of(context).size.height / 5.1),
                      crossAxisCount: 2,

                      children: List.generate(data.ebooks.length, (index) => Ebook(ebook: data.ebooks[index])),
                    ),

                  );
                }
              )
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
