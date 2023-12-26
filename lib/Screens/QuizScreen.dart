import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/Screens/quiz_screen.dart';
import 'package:hip_quest/Screens/result_screen.dart';
import 'package:hip_quest/Widgets/DashboardBox.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:http/http.dart' as http;
import '../Widgets/GlobalAppBar.dart';

class QuizInfoScreen extends StatefulWidget {
  static String routeKey = '/quizes';
  final bool appbar;

  const QuizInfoScreen({Key? key, required this.appbar}) : super(key: key);

  @override
  State<QuizInfoScreen> createState() => _QuizInfoScreenState();
}

class _QuizInfoScreenState extends State<QuizInfoScreen> {
  String currentpoints = "";
  String remainingquiz = "";
  String competedquiz = "";
  String maxpointfordiscount = "";
  String totalpoint = "";
  String discount = "";
  List<dynamic> remainingquizlist = [];
  List<dynamic> completedquizlist = [];
  bool showloader = true;

  Future<void> fetchpoint() async {
    final String apiUrl =
        '${AppConstants.stagingurl}v1/quizzes/points?user_id=$userid';
    print(apiUrl);

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        currentpoints = jsonData["data"]["your_points"].toString();
        totalpoint = jsonData["data"]["total_points"].toString();
      });
      print(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchquiz() async {
    final String apiUrl =
        '${AppConstants.stagingurl}v1/all_quizzes?user_id=$userid';
    // "${AppConstants.stagingurl}v1/all_quizzes?user_id=$userid";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      showloader = false;
      final jsonData = json.decode(response.body);
      for (int i = 0; i < jsonData["data"]["completed"].length; i++) {
        completedquizlist.add(jsonData["data"]["completed"][i]);
      }
      for (int a = 0; a < jsonData["data"]["remaining"].length; a++) {
        remainingquizlist.add(jsonData["data"]["remaining"][a]);
      }
      print("the length for remaining list${remainingquizlist.length}");
      print("the length for completed list${completedquizlist.length}");
      setState(() {
        remainingquiz = jsonData["remaining_quizzes"].toString();
        competedquiz = jsonData["completed_quizzes"].toString();
        maxpointfordiscount =
            jsonData["quiz_discount"]["max_points"].toString();
        discount = jsonData["quiz_discount"]["discount_percent"].toString();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    fetchpoint();
    fetchquiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return (showloader == true)
        ? loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorResources.colorSecondary,
            // appBar: (widget.appbar == true)
            //     ? AppBar(
            //         centerTitle: true,
            //         elevation: 0,
            //         title: RichText(
            //           text: TextSpan(
            //             children: [
            //               TextSpan(
            //                 style: sansSemiBold.copyWith(
            //                   color: ColorResources.colorPrimary,
            //                   fontSize: Dimensions.fontSizeOverLarge,
            //                 ),
            //                 text: "Hip",
            //               ),
            //               TextSpan(
            //                 style: sansLight.copyWith(
            //                   color: ColorResources.colorPrimary,
            //                   fontSize: Dimensions.fontSizeOverLarge,
            //                   fontWeight: FontWeight.w300,
            //                 ),
            //                 text: "Quest",
            //               )
            //             ],
            //           ),
            //         ),
            //         backgroundColor: Colors.transparent,
            //         leading: IconButton(
            //           onPressed: () => Navigator.pop(context),
            //           icon: const Icon(
            //             Icons.arrow_back,
            //             color: ColorResources.colorPrimary,
            //           ),
            //         ),
            //       )
            //     : null,
            body: SafeArea(
              bottom: false,
              left: false,
              right: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/quiz.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              // height: height / 3.5,
                              // width: width,
                              decoration: BoxDecoration(
                                  color: ColorResources.colorPrimary,
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CircularProgressIndicator(
                                        value: double.parse(currentpoints) /
                                            double.parse(totalpoint),
                                        strokeWidth: 26,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white.withOpacity(0.5)),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 35, horizontal: 40),
                                      child: Column(
                                        children: [
                                          Text(
                                            currentpoints,
                                            style: sansSemiBold.copyWith(
                                                color: ColorResources.white,
                                                fontSize: 40,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "Your Score",
                                            style: sansSemiBold.copyWith(
                                                color: ColorResources.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: height / 9,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/blur.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.white),
                                  // color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorResources.colorPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          remainingquiz,
                                          style: sansSemiBold.copyWith(
                                              color:
                                                  ColorResources.colorPrimary,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Remaining",
                                          style: sansSemiBold.copyWith(
                                              color: ColorResources.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Spacer(),
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorResources.colorPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text(
                                          competedquiz,
                                          style: sansSemiBold.copyWith(
                                              color:
                                                  ColorResources.colorPrimary,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Completion",
                                          style: sansSemiBold.copyWith(
                                              color: ColorResources.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Center(
                              child: Text(
                                "Reach $maxpointfordiscount points to earn $discount% discount on HA joining Fee.",
                                style: sansSemiBold.copyWith(
                                    color: ColorResources.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        "Remaining Quizzes",
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < remainingquizlist.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print(
                                      "the id is${remainingquizlist[i]["quiz"]}");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QuizScreen(
                                          id: remainingquizlist[i]["ID"],
                                          quizname: remainingquizlist[i]
                                              ["quiz_name"],
                                          quizdescription: remainingquizlist[i]
                                              ["description"],
                                          image: remainingquizlist[i]["image"],
                                          quizData: remainingquizlist[i]
                                              ["quiz"]),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height / 9,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: ColorResources.colorPrimary
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Image border
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(
                                                48), // Image radius
                                            child: Image.network(
                                              remainingquizlist[i]["image"],
                                              fit: BoxFit.fill,
                                              height: height / 9,
                                              width: width / 3.5,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15.0),
                                        Text(
                                          remainingquizlist[i]["quiz_name"],
                                          style: sansSemiBold.copyWith(
                                              color: ColorResources.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        "Completed Quizzes",
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < completedquizlist.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: height / 9,
                                width: width,
                                decoration: BoxDecoration(
                                    color: ColorResources.colorPrimary
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Image border
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(
                                              48), // Image radius
                                          child: Image.network(
                                            completedquizlist[i]["image"],
                                            fit: BoxFit.fill,
                                            height: height / 9,
                                            width: width / 3.5,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.0),
                                      Text(
                                        completedquizlist[i]["quiz_name"],
                                        style: sansSemiBold.copyWith(
                                            color: ColorResources.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QuizScreen(
                                          id: completedquizlist[0]["ID"],
                                          quizname: completedquizlist[0]
                                              ["quiz_name"],
                                          quizdescription: completedquizlist[0]
                                              ["description"],
                                          image: completedquizlist[0]["image"],
                                          quizData: completedquizlist[0]
                                              ["quiz"]),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height / 12,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: ColorResources.colorPrimary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      "Play again",
                                      style: sansSemiBold.copyWith(
                                          color: ColorResources.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              GestureDetector(
                                onTap: (havehistory == false)
                                    ? () {
                                        var snackBar = SnackBar(
                                            content: Text(
                                                "Play a quiz to review answers!"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ResultScreen(
                                              resultData: resultData,
                                            ),
                                          ),
                                        );
                                      },
                                child: Center(
                                  child: Text(
                                    "Review Answer",
                                    style: sansSemiBold.copyWith(
                                        color: ColorResources.colorPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          SizedBox(width: 30.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
