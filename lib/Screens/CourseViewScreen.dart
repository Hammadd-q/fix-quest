import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Provider/CourseProvider.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class CoursesViewScreen extends StatefulWidget {
  static String routeKey = '/courseview';
  final int courseId;
  final int index;

  const CoursesViewScreen({Key? key, required this.courseId, required this.index}) : super(key: key);

  @override
  State<CoursesViewScreen> createState() => _CoursesViewScreenState();
}

class _CoursesViewScreenState extends State<CoursesViewScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseProvider>(context, listen: false).getCourse(context, widget.courseId, widget.index);
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
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Consumer<CourseProvider>(
                    builder: (_, data, __) {
                      print(data.course);
                      if(data.course == null) {
                        return const SizedBox();
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: 350,
                            height: 190,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  elevation: 15,
                                  color: ColorResources.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: ColorResources.white, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      data.courseSection?.image ?? data.course?.image ?? ImagesResources.noImageUrl,
                                      fit: BoxFit.fill,
                                      width: 220,
                                      height: 250,
                                    ),
                                  )),
                            ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(20),
                            //   child: Container(
                            //     color: ColorResources.white,
                            //     child: const Image(
                            //       image: AssetImage(ImagesResources.applogo)
                            //     ),
                            //   ),
                            // ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30, top: 10, right: 15),
                            child: Text(data.courseSection?.title ?? data.course?.title ?? '',
                                style: sansSemiBold.copyWith(
                                    color: ColorResources.black,
                                    fontSize: Dimensions.iconSizeDefault,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("${data.course?.progress}%",
                                      style: sansSemiBold.copyWith(
                                          color: ColorResources.colorPrimary,
                                          fontSize: Dimensions.fontSizeMedium,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.left),
                                  Container(
                                    width: 219,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                        color: ColorResources.white),
                                    child: Container(
                                        width: 90,
                                        height: 5,
                                        decoration: const BoxDecoration(
                                            color: ColorResources.colorPrimary)),
                                  )
                                ],
                              ),
                              // Rectangle 960
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                    width: 98,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15)),
                                        color: Color(0xff484349)),
                                    child: Center(
                                      child: Text("Points 13/20",
                                          style: sansSemiBold.copyWith(
                                              color: ColorResources.white,
                                              fontSize:
                                                  Dimensions.fontSizeExtraSmall,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.left),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 149,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(18)),
                                          color: Color(0xfff1f1f1)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2, right: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              size: 16,
                                              color: ColorResources.black,
                                            ),
                                            const SizedBox(width: 1),
                                            Text(data.course?.createdAt ?? '',
                                                style: sansSemiBold.copyWith(
                                                    color: ColorResources.black,
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 5, right: 5),
                                      child: Opacity(
                                        opacity: 0.3199999928474426,
                                        child: Container(
                                          width: 149,
                                          height: 36,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                              color: Color(0xff3fac0f)),
                                          child: Center(
                                              child: Text("Enrolled",
                                                  style: sansSemiBold.copyWith(
                                                      color: ColorResources.black,
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
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
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Html(
                                data: data.courseSection?.body ?? data.course?.body ?? "",
                            )
                          ),

                          // GestureDetector(
                          //   onTap: () {
                          //
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 15,right: 15),
                          //     child: Container(
                          //         margin: const EdgeInsets.only(top: 30),
                          //         width: double.infinity,
                          //         height: 50,
                          //         decoration: const BoxDecoration(
                          //             borderRadius: BorderRadius.all(Radius.circular(8)),
                          //             color: ColorResources.colorPrimary),
                          //         child: Center(
                          //             child: Text(
                          //               "Download PDF",
                          //               style: sansSemiBold.copyWith(
                          //                   color: ColorResources.white,
                          //                   fontSize: Dimensions.fontSizeSmall,
                          //                   fontWeight: FontWeight.w400),
                          //             ))),
                          //   ),
                          // ),
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                const Padding(
                                  padding:
                                      EdgeInsets.only(left: 20, top: 10, right: 20),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Lessons",
                                                  style: sansSemiBold.copyWith(
                                                      color: ColorResources
                                                          .colorPrimary,
                                                      fontSize:
                                                          Dimensions.iconSizeSmall,
                                                      fontWeight: FontWeight.w400),
                                                  textAlign: TextAlign.left),
                                              const SizedBox(height: 20),
                                              ...List.generate(data.course?.courseSections.length ?? 0, (index) =>  CourseContent(
                                                number: '0${index + 1}',
                                                title: data.course?.courseSections[index].title ?? '',
                                                isClick: false,
                                                onClick: () {
                                                  Provider.of<CourseProvider>(context, listen: false).selectSection(data.course?.courseSections[index]);
                                                }
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
