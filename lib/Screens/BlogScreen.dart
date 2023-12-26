import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

import '../helper/Helpers.dart';

class BlogScreen extends StatefulWidget {
  static String routeKey = '/blog';

  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).getBlogs(context,responseHandler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Blogs'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextInput(
                textName: "Search Blogs",
                onChanged: Provider.of<BlogProvider>(context, listen: false).search,
                icon: const Icon(
                  Icons.search,
                  color: ColorResources.colorPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Consumer<BlogProvider>(
                  builder: (_, data, __) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.blogs.length,
                      itemBuilder: (context, index) {
                        return Blogs(blog: data.blogs[index]);
                      },
                    );
                  }
                ),
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
    }
    Helpers.showSuccessToast(context, message);
    Navigator.pop(context);
  }
}
