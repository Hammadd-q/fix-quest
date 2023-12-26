import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/data/model/message_model.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../data/model/chat_room_model.dart';
import '../data/model/user_model.dart';

var uuid = const Uuid();

class ChatRoomScreen extends StatefulWidget {
  final UserModel targetUser;
  final UserModel userModel;
  final ChatRoomModel? chatRoom;

  const ChatRoomScreen(
      {Key? key,
      required this.chatRoom,
      required this.userModel,
      required this.targetUser})
      : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    messageController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    String? message = messageController.text.trim();
    messageController.clear();

    String senderFullName =
        "${widget.userModel.userName} ${widget.userModel.userLastName}";
    if (message.isNotEmpty) {
      MessageModel messageModel = MessageModel(
        text: message,
        messageId: uuid.v1(),
        sender: widget.userModel.userId,
        senderName: senderFullName,
        sentTime: DateTime.now(),
        seen: false,
      );

      // await not used, can store message when internet not available
      await FirebaseFirestore.instance
          .collection(AppConstants.firebaseChatRooms)
          .doc(widget.chatRoom?.chatRoomId)
          .collection(AppConstants.firebaseMsg)
          .doc(messageModel.messageId)
          .set(
            messageModel.toMap(),
          )
          .whenComplete(
        () {
          if (!widget.targetUser.fcmKey!.contains("emulator")) {
            pushNotificationsSpecificDevice(
                token: widget.targetUser.fcmKey,
                title: messageModel.senderName,
                body: messageModel.text);

            log("Notification sent");
          }

          log("Message sent");
        },
      );

      widget.chatRoom?.lastMessage = message;
      await FirebaseFirestore.instance
          .collection(AppConstants.firebaseChatRooms)
          .doc(widget.chatRoom?.chatRoomId)
          .set(
            widget.chatRoom!.toMap(),
          );
    }
  }

  var timeFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: ColorResources.colorPrimary,
              ),
            ),
            widget.targetUser.userDpUrl.toString().isNotEmpty
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.targetUser.userDpUrl.toString()),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
            const SizedBox(width: 20.0 * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.targetUser.userName.toString()} ${widget.targetUser.userLastName.toString()}",
                  style: sansLight.copyWith(
                    color: ColorResources.black,
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 1),
                StreamBuilder(
                  // get user isOnline status
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(widget.targetUser.userId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    // red color for offline , green color for online
                    return snapshot.hasData
                        ? snapshot.data!.get("isOnline")
                            ? Text(
                                "Online",
                                style: sansLight.copyWith(
                                  color: ColorResources.black,
                                  fontSize: Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                "Offline",
                                style: sansLight.copyWith(
                                  color: ColorResources.black,
                                  fontSize: Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                        : Text(
                            "Offline",
                            style: sansLight.copyWith(
                              color: ColorResources.black,
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
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
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(AppConstants.firebaseChatRooms)
                        .doc(widget.chatRoom?.chatRoomId)
                        .collection(AppConstants.firebaseMsg)
                        .orderBy("sentTime", descending: true)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorResources.colorPrimary,
                          ),
                        );
                      } else {
                        if (snapshot.hasData) {
                          QuerySnapshot querySnapshot =
                              snapshot.data as QuerySnapshot;
                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: querySnapshot.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              MessageModel currentMessage =
                                  MessageModel.fromMap(
                                querySnapshot.docs[index].data()
                                    as Map<String, dynamic>,
                              );
                              return Row(
                                mainAxisAlignment: currentMessage.sender ==
                                        widget.userModel.userId
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onLongPress: () async {
                                      await FirebaseFirestore.instance
                                          .collection(
                                              AppConstants.firebaseChatRooms)
                                          .doc(widget.chatRoom?.chatRoomId)
                                          .collection(AppConstants.firebaseMsg)
                                          .doc(currentMessage.messageId)
                                          .delete();
                                    },
                                    onDoubleTap: () async {
                                      // edit message
                                      if (messageController.text.isNotEmpty) {
                                        await FirebaseFirestore.instance
                                            .collection(
                                                AppConstants.firebaseChatRooms)
                                            .doc(widget.chatRoom?.chatRoomId)
                                            .collection(
                                                AppConstants.firebaseMsg)
                                            .doc(currentMessage.messageId)
                                            .update({
                                          "text": messageController.text,
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    splashColor: Colors.green,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            currentMessage.sender ==
                                                    widget.userModel.userId
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: (currentMessage
                                                          .sender ==
                                                      widget.userModel.userId)
                                                  ? const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    )
                                                  : const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    ),
                                              color: (currentMessage.sender ==
                                                      widget.userModel.userId)
                                                  ? ColorResources.colorPrimary
                                                  : ColorResources
                                                      .colorSecondary,
                                            ),
                                            child: Text(
                                              currentMessage.text.toString(),
                                              textAlign: currentMessage
                                                          .sender ==
                                                      widget.userModel.userId
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                              style: sansLight.copyWith(
                                                color: (currentMessage.sender ==
                                                        widget.userModel.userId)
                                                    ? ColorResources.white
                                                    : ColorResources.black,
                                                fontSize:
                                                    Dimensions.fontSizeMedium,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // Text(timeFormat.format(currentMessage.sentTime!),
                                          //   style: const TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            snapshot.error.toString(),
                            style: sansLight.copyWith(
                              color: ColorResources.colorPrimary,
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              "No Message",
                              style: sansLight.copyWith(
                                color: ColorResources.colorPrimary,
                                fontSize: Dimensions.fontSizeSmall,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  width: 339,
                  height: 69,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      color: ColorResources.chatTextBox),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          style: TextStyle(
                            color: ColorResources.black,
                          ),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type Something..."),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sendMessage();
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

  Future<bool> pushNotificationsSpecificDevice({
    required String? token,
    required String? title,
    required String? body,
  }) async {
    String dataNotifications = '{ "to" : "$token",'
        ' "notification" : {'
        ' "title":"$title",'
        '"body":"$body"'
        ' }'
        ' }';

    await http.post(
      Uri.parse(AppConstants.fcmBaseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${AppConstants.serverKey}',
      },
      body: dataNotifications,
    );
    return true;
  }
}
