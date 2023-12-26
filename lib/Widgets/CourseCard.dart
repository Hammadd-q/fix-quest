import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/util/Utils.dart';

class CourseCard extends StatelessWidget {
  final Widget imgScr;
  final int courseId;
  final String title;
  final String progress;
  final String date;
  final String enroll;
  final int index;

  const CourseCard({
    Key? key,
    required this.courseId,
    required this.imgScr,
    required this.title,
    required this.progress,
    required this.date,
    required this.enroll,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CoursesViewScreen(courseId: courseId, index: index)));
      },
      child: Container(
        alignment: Alignment.center, // This is needed
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: ColorResources.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8, offset: const Offset(3, 1))]),
          child: SizedBox(
            width: 170,
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 170, height: 100, child: imgScr),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 30,
                          child: Text(title,
                              style: sansSemiBold.copyWith(
                                color: ColorResources.black,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              textAlign: TextAlign.left),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(progress,
                            style: sansSemiBold.copyWith(
                                color: ColorResources.colorPrimary,
                                fontSize: Dimensions.fontSizeExtraSmall,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left),
                        Container(
                            width: 150,
                            height: 5,
                            decoration:
                            const BoxDecoration(color: Color(0xfffed5dd))),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Container(
                              width: 85,
                              height: 20,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xfff1f1f1)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2, right: 2),
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 16,
                                      color: ColorResources.black,
                                    ),
                                    const SizedBox(width: 1),
                                    Text(date,
                                        style: sansSemiBold.copyWith(
                                            color: ColorResources.black,
                                            fontSize: Dimensions.fontSizeExtraSmall,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 2,bottom: 5,top: 4),
                              child: Opacity(
                                opacity: 0.3199999928474426,
                                child: Container(
                                  width: 55,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xff3fac0f)),
                                  child: Center(
                                      child: Text(enroll,
                                          style: sansSemiBold.copyWith(
                                              color: ColorResources.black,
                                              fontSize: Dimensions.fontSizeExtraSmall,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left)),
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

