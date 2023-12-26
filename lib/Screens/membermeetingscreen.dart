import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Screens/WebviewScreens.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

import '../util/dimensions.dart';

class MemberMeetingScreen extends StatefulWidget {
  static String routeKey = '/membermeeting';

  const MemberMeetingScreen({Key? key}) : super(key: key);

  @override
  State<MemberMeetingScreen> createState() => _MemberMeetingScreenState();
}

class _MemberMeetingScreenState extends State<MemberMeetingScreen> {
  Map<String, dynamic> meetingData = {};

  @override
  void initState() {
    super.initState();
    fetchMeetingData();
  }

  Future<void> fetchMeetingData() async {
    final apiUrl = '${AppConstants.stagingurl}member_meetings?user_id=$userid';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      setState(() {
        meetingData = data;
      });
    } else {
      throw Exception('Failed to load meeting data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: sansSemiBold.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                ),
                text: "Member",
              ),
              TextSpan(
                style: sansLight.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                  fontWeight: FontWeight.w300,
                ),
                text: " Meetings",
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.colorPrimary,
          ),
        ),
      ),
      body: meetingData.isEmpty
          ? loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Html(data: meetingData['content']),
                    SizedBox(height: 16),
                    Divider(
                      height: 5,
                      color: ColorResources.errorStatus,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Text(
                        'Meeting Recordings:',
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeMedium,
                        ),
                      ),
                    ),
                    // SizedBox(height: 8),
                    Divider(
                      height: 5,
                      color: ColorResources.errorStatus,
                    ),
                    SizedBox(height: 15),
                    for (var recording in meetingData['meeting_recordings'])
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recording['title'],
                            style: sansSemiBold.copyWith(
                              color: ColorResources.black,
                              fontSize: Dimensions.fontSizeExtraLarge,
                            ),
                          ),
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              collapsedIconColor: ColorResources.red,
                              iconColor: ColorResources.successStatus,
                              collapsedTextColor: ColorResources.red,
                              textColor: ColorResources.successStatus,
                              title: Text(
                                "About",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Html(data: recording['about']),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 300,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: WebView(
                          //     initialUrl: recording['about'],
                          //     javascriptMode: JavascriptMode.unrestricted,
                          //     onPageFinished: (finish) {},
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Text(
                              'Sessions',
                              style: sansSemiBold.copyWith(
                                color: ColorResources.colorPrimary,
                                fontSize: Dimensions.fontSizeMedium,
                              ),
                            ),
                          ),
                          for (var video in recording['recordings'])
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => WebviewScreen(
                                    //         url: video['webview_video_url'],
                                    //         title: recording['title'],
                                    //       ),
                                    //     ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                ColorResources.successStatus)),
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                        // Html(data: video['session']),
                                        // Text(video['session'])

                                        WebView(
                                      initialUrl: video['webview_video_url'],
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      onPageFinished: (finish) {},
                                    ),
                                  )),
                            ),
                          SizedBox(height: 16),
                          Divider(
                            height: 5,
                            color: ColorResources.errorStatus,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
