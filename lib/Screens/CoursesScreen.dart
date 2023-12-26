import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/CourseProvider.dart';
import 'package:provider/provider.dart';

import '../Widgets/Widgets.dart';
import '../helper/Helpers.dart';
import '../util/ColorResources.dart';
import '../util/Utils.dart';

class CoursesScreen extends StatefulWidget {
  static String routeKey = '/courses';

  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseProvider>(context, listen: false).getCourses(context,responseHandler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Courses'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<CourseProvider>(builder: (_, data, __) {
            return GridView.count(
              padding: EdgeInsets.zero,
              childAspectRatio: (MediaQuery.of(context).size.width / 3.3) /
                  (MediaQuery.of(context).size.height / 5.3),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: List.generate(
                data.courses.length,
                (index) => CourseCard(
                  courseId: data.courses[index].id,
                  imgScr: data.courses[index].image == ''
                      ? Image.network(
                          ImagesResources.noImageUrl,
                          fit: BoxFit.fill,
                          width: 220,
                          height: 250,
                        )
                      : Image.network(
                          data.courses[index].image,
                          fit: BoxFit.fill,
                          width: 220,
                          height: 250,
                        ),
                  title: data.courses[index].title,
                  progress: "0%",
                  date: data.courses[index].createdAt,
                  enroll: "Enrolled",
                  index: index,
                ),
              ),
            );
          }),
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
