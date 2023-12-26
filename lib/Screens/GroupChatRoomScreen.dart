import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../data/model/GroupMessageModel.dart';
import '../util/AppConstants.dart';

final _firestore = FirebaseFirestore.instance;

class GroupChatRoomScreen extends StatefulWidget {
  static String routeKey = '/groupchatroom';

  const GroupChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<GroupChatRoomScreen> createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  String? messageText;
  String? senderEmail;

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void sendMsg() async {
    var prefs = await SharedPreferences.getInstance();
    senderEmail = prefs.getString(AppConstants.userEmail) ?? "";
    String profilePic = prefs.getString(AppConstants.profileImage) ?? "";
    String firstName = prefs.getString(AppConstants.firstName) ?? "";


    String currentDate = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    String currentTime = DateFormat("hh:mm:ss a").format(DateTime.now());

    messageController.clear();
    if (messageText != "") {
      // Send Message
      GroupMessageModel groupMessageModel = GroupMessageModel(senderEmail,
          firstName, messageText, profilePic, false, true, DateTime.now());
      _firestore.collection("group_chatroom").add(groupMessageModel.toMap());
      
      pushNotificationsAllUsers(
        title: firstName,
        body: messageText,
      );
    }
  }

  void getCurrentUser() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      // var currentUserModel = CurrentUserModel();
      // currentUserModel.id = prefs.getString(AppConstants.userId) ?? "";
      // currentUserModel.email = prefs.getString(AppConstants.userEmail) ?? "";
      // currentUserModel.firstname = prefs.getString(AppConstants.firstName) ?? "";
      // currentUserModel.lastname = prefs.getString(AppConstants.lastName) ?? "";
      // currentUserModel.profile = prefs.getString(AppConstants.profileImage) ?? "";
      // currentUserModel.fcmKey = prefs.getString(AppConstants.fcmToken) ?? "";
      // currentUserModel.status = "Offline";
      senderEmail = prefs.getString(AppConstants.userEmail) ?? "";

      print("currentUserModel $senderEmail");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  ColorResources.colorSecondary,
      appBar: const ChatAppBar(
        title: 'Hip Quest Announcement',
        onlineStatus: "Online",
      ),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Container(
          color: ColorResources.white,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                StreamBuilder(
                    stream: _firestore
                        .collection(AppConstants.firebaseGroupChatRoom)
                        .orderBy('createdon', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          // final messages = snapshot.data?.docChanges.reversed;
                          final messages = dataSnapshot.docChanges.reversed;
                          List<MessageBubble> messageBubbles = [];

                          for (var message in messages) {
                            final messageText = message.doc['text'];
                            final messageSender = message.doc['sender'];
                            final firstName = message.doc['name'];
                            final currentUser = senderEmail;

                            final messageBubble = MessageBubble(
                              sender: messageSender,
                              text: messageText,
                              isMe: currentUser == messageSender,
                            );

                            messageBubbles.add(messageBubble);
                          }
                          return Expanded(
                            child: ListView(
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              children: messageBubbles,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                "An error occurred! Please check your internet connection."),
                          );
                        } else {
                          return const Center(
                            child: Text("Say hi to your new friend"),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorResources.colorPrimary,
                          ),
                        );
                      }
                    }),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  width: 339,
                  height: 69,
                  decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      color:ColorResources.chatTextBox),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          maxLines: null,
                          style:  const TextStyle(color:  ColorResources.black),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type Something..."),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMsg();
                        },
                        child: Container(
                          width: 58,
                          height: 53,
                          decoration: const BoxDecoration(
                            color: ColorResources.errorStatus,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(ImagesResources.send)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> pushNotificationsAllUsers({
    required String? title,
    required String? body,
  }) async {
    FirebaseMessaging.instance.subscribeToTopic("Hip Quest Announcement");

    String dataNotifications = '{ '
        ' "to" : "/topics/HipQuestAnnouncement" , '
        ' "notification" : {'
        ' "title":"$title" , '
        ' "body":"$body" '
        ' } '
        ' } ';

    var response = await http.post(
      Uri.parse(AppConstants.fcmBaseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${AppConstants.serverKey}',
      },
      body: dataNotifications,
    );
    print(response.body.toString());
    return true;
  }
}
