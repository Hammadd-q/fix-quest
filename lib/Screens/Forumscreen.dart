import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:http/http.dart' as http;

class ForumScreen extends StatefulWidget {
  static const String routeKey = '/forums';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<Map<String, dynamic>> forums = [];
  bool showloader = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri url =
        Uri.parse('${AppConstants.stagingurl}forums?user_id=$userid');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        showloader = false;
      });
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] == 0) {
        setState(() {
          forums = List<Map<String, dynamic>>.from(data['data']);
        });
      }
    } else {
      showloader = false;
      throw Exception('Failed to load forums');
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
                text: "Forums",
              ),
              TextSpan(
                style: sansLight.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                  fontWeight: FontWeight.w300,
                ),
                text: " ",
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
      body: (showloader == true)
          ? loading()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: (forums.length < 1)
                  ? Center(
                      child: Text(
                      "No Events found.",
                      style: sansRegular.copyWith(
                        color: ColorResources.darkGrey,
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                    ))
                  : ListView.builder(
                      itemCount: forums.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            color:
                                ColorResources.chatSubTitle, // Background color
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Center(
                                  child: Text(forums[index]['title'],
                                      style: TextStyle(
                                        color: Colors.white, // Text color
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("Total Topics",
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Spacer(),
                                    Text(forums[index]['topic_count'],
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("Total Replies",
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Spacer(),
                                    Text(forums[index]['reply_count'],
                                        style: TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                            onTap: () {
                              navigateToForumDetails(forums[index]['id']);
                            },
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  void navigateToForumDetails(int forumId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForumDetailsScreen(forumId: forumId),
      ),
    );
  }
}

class ForumDetailsScreen extends StatefulWidget {
  final int forumId;

  ForumDetailsScreen({required this.forumId});

  @override
  _ForumDetailsScreenState createState() => _ForumDetailsScreenState();
}

class _ForumDetailsScreenState extends State<ForumDetailsScreen> {
  List<Map<String, dynamic>> topics = [];

  @override
  void initState() {
    super.initState();
    fetchForumDetails();
  }

  Future<void> fetchForumDetails() async {
    final Uri url = Uri.parse(
        '${AppConstants.stagingurl}forums/${widget.forumId}?user_id=$userid');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] == 0) {
        setState(() {
          topics = List<Map<String, dynamic>>.from(data['data']['topics']);
        });
      }
    } else {
      throw Exception('Failed to load forum details');
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
                text: "Forum",
              ),
              TextSpan(
                style: sansLight.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                  fontWeight: FontWeight.w300,
                ),
                text: " Topics",
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
      body: topics.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(), // Show a loader while fetching data
            )
          : ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: ColorResources.colorPrimary, // Background color
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Center(
                            child: Text(
                              topics[index]['title'],
                              style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Author Name:",
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              // Spacer(),
                              Flexible(
                                child: Text(topics[index]['author_name'],
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text("Total Replies",
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              Text(topics[index]['reply_count'],
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                      onTap: () {
                        navigateToTopicDetails(topics[index]['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void navigateToTopicDetails(int topicId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TopicDetailsScreen(topicId: topicId),
      ),
    );
  }
}

class TopicDetailsScreen extends StatefulWidget {
  final int topicId;

  TopicDetailsScreen({required this.topicId});

  @override
  _TopicDetailsScreenState createState() => _TopicDetailsScreenState();
}

class _TopicDetailsScreenState extends State<TopicDetailsScreen> {
  Map<String, dynamic> topicDetails = {};

  @override
  void initState() {
    super.initState();
    fetchTopicDetails();
  }

  Future<void> fetchTopicDetails() async {
    final Uri url = Uri.parse(
        '${AppConstants.stagingurl}topics/${widget.topicId}?user_id=$userid');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] == 0) {
        setState(() {
          topicDetails = data['data'];
        });
      }
    } else {
      throw Exception('Failed to load topic details');
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
                  text: "Topic",
                ),
                TextSpan(
                  style: sansLight.copyWith(
                    color: ColorResources.colorPrimary,
                    fontSize: Dimensions.fontSizeOverLarge,
                    fontWeight: FontWeight.w300,
                  ),
                  text: " Details",
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
        body: topicDetails.isEmpty
            ? Center(
                child:
                    CircularProgressIndicator(), // Show a loader while fetching data
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                              ColorResources.successStatus, // Background color
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Container(
                                      height: 150,
                                      width: 150,
                                      child: Image.network(
                                          topicDetails['author_avatar'])),
                                  Spacer()
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  topicDetails['title'],
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Author:',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text(
                                      '${topicDetails['author_name']}',
                                      style: TextStyle(
                                        color: Colors.white, // Text color
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Replies:',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${topicDetails['reply_count']}',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Posted Date',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text(
                                      '${topicDetails['post_date']}',
                                      style: TextStyle(
                                        color: Colors.white, // Text color
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Html(data: topicDetails['content']),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      replyscreen(widget.topicId)
                    ],
                  ),
                ),
              ));
  }
}

class replyscreen extends StatefulWidget {
  final int topicid;
  replyscreen(this.topicid);
  @override
  _replyscreenState createState() => _replyscreenState();
}

class _replyscreenState extends State<replyscreen> {
  TextEditingController replyController = TextEditingController();
  List<Reply> replies = [];
  bool isReplying = false;
  int replyToId = 34877;
  String? nameofuser;

  @override
  void initState() {
    // Fetch replies for the initial topic (ID 34877)
    fetchReplies(widget.topicid);
    super.initState();
  }

  void fetchReplies(int topicId) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.stagingurl}topics/${widget.topicid}?user_id=$userid'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'];
      final replyData = data['replies'];

      List<Reply> fetchedReplies = [];
      for (var replyJson in replyData) {
        fetchedReplies.add(Reply.fromJson(replyJson));
      }

      setState(() {
        replies = fetchedReplies;
      });
    } else {
      // Handle the error
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(10),
          insetPadding: EdgeInsets.all(8),
          title: Text("$nameofuser's reply"),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Spacer(),
                TextField(
                  controller: replyController,
                  decoration: InputDecoration(
                      labelText: "You are replying to $nameofuser's reply"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      ColorResources.colorPrimary,
                    ),
                  ),
                  onPressed: () {
                    postReply(replyController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('Send Reply'),
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> submitForm(String content) async {
    print("reply to reply");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConstants.stagingurl}replies/$replyToId'));
    request.fields['user_id'] = "$userid";
    request.fields['content'] = content;

    print(request.fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBytes = await response.stream.toBytes();
      final responseString = utf8.decode(responseBytes);
      final jsonData = json.decode(responseString);
      // Handle successful reply
      setState(() {
        isReplying = false;
      });
      // Fetch updated replies
      fetchReplies(replyToId);
      print("success");
    } else {
      print(response.statusCode);
      print('Error: ${response.stream.bytesToString()}');
    }
  }

  Future<void> postReply(String content) async {
    submitForm(content);
  }

  Future<void> submitFormm(String content) async {
    print("reply to topic");
    var request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.stagingurl}topics/${widget.topicid}'));
    request.fields['user_id'] = "$userid";
    request.fields['content'] = content;

    print(request.fields);
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBytes = await response.stream.toBytes();
      final responseString = utf8.decode(responseBytes);
      final jsonData = json.decode(responseString);
      // Handle successful reply
      setState(() {
        isReplying = false;
      });
      // Fetch updated replies
      fetchReplies(replyToId);
      print("success");
    } else {
      print(response.statusCode);
      print('Error: ${response.stream.bytesToString()}');
    }
  }

  Future<void> postReplyy(String content) async {
    submitFormm(content);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 1000,
      child: Column(
        children: [
          for (int i = 0; i < replies.length; i++)
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(replies[i].authorName),
                  subtitle: Html(data: replies[i].content),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        ColorResources.colorPrimary,
                      ),
                    ),
                    onPressed: () {
                      replyController.clear();
                      _showDialog(context);
                      setState(() {
                        isReplying = true;

                        replyToId = replies[i].id;
                        nameofuser = replies[i].authorName;
                      });
                    },
                    child: Text('Reply'),
                  ),
                ),
                Divider()
              ],
            ),
          TextField(
            controller: replyController,
            decoration: InputDecoration(labelText: "Write your reply"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                ColorResources.colorPrimary,
              ),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              postReplyy(replyController.text);
              replyController.clear();
            },
            child: Text('Send Reply'),
          ),
        ],
      ),
    );
  }
}

class Reply {
  final int id;
  final String content;
  final String authorName;

  Reply({
    required this.id,
    required this.content,
    required this.authorName,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      content: json['content'],
      authorName: json['author_name'],
    );
  }
}
