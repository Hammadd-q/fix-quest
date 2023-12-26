import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/ChatRoomScreen.dart';
import 'package:hip_quest/Screens/loading.dart';
import 'package:hip_quest/data/model/chat_room_model.dart';
import 'package:hip_quest/data/model/user_model.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/firebase_helper.dart';

import '../util/AppConstants.dart';
import '../util/ColorResources.dart';
import '../util/CustomThemes.dart';
import '../util/Dimensions.dart';

class ChatTab extends StatefulWidget {
  final UserModel? userModel;

  const ChatTab({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  void initState() {
    super.initState();
  }

  execute() async {
    await getChatRooms();
    await getChatRooms();
    await getChatRooms();
    await getChatRooms();
    await getChatRooms();
    await getChatRooms();
  }

  Future<QuerySnapshot> getChatRooms() async {
    print("object");
    dynamic respone = FirebaseFirestore.instance
        .collection(AppConstants.firebaseChatRooms)
        .where("participants.${widget.userModel?.userId}", isEqualTo: true)
        .get();

    return respone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      body: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: FutureBuilder(
            future: getChatRooms(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingIndicator();
                // buildLoadingIndicator();
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error.toString());
                // buildErrorWidget(snapshot.error.toString());
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                QuerySnapshot querySnapshot = snapshot.data!;
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(AppConstants.firebaseChatRooms)
                      .where("participants.${widget.userModel?.userId}",
                          isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return _buildLoadingIndicator();
                      // buildLoadingIndicator();
                    } else if (streamSnapshot.hasError) {
                      return _buildErrorWidget(streamSnapshot.error.toString());
                    } else {
                      QuerySnapshot queryStreamSnapshot =
                          streamSnapshot.data as QuerySnapshot;
                      return _buildChatList(queryStreamSnapshot);
                    }
                  },
                );
              } else {
                getChatRooms();
                return _buildNoChatsWidget();
              }
            },
          )),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: loading(),
    );
  }

  Widget _buildChatList(QuerySnapshot querySnapshot) {
    return ListView.builder(
      itemCount: querySnapshot.docs.length,
      itemBuilder: (BuildContext context, int index) {
        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
          querySnapshot.docs[index].data() as Map<String, dynamic>,
        );

        List<String?> participantsKeys = chatRoomModel.participants!.keys
            .where((element) => element != widget.userModel?.userId)
            .toList();

        return _buildChatRoomItem(chatRoomModel, participantsKeys);
      },
    );
  }

  Widget _buildChatRoomItem(
      ChatRoomModel chatRoomModel, List<String?> participantsKeys) {
    return FutureBuilder(
      future: FirebaseHelper.getUserModelById(participantsKeys[0]),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(),
          );
        } else {
          if (data.hasData) {
            UserModel targetUser = data.data as UserModel;
            return _buildChatRoomWidget(chatRoomModel, targetUser);
          } else if (data.hasError) {
            return Center(child: Text(data.error.toString()));
          } else {
            return const Center(
              child: Text("No chats yet. Start chatting with someone"),
            );
          }
        }
      },
    );
  }

  Widget _buildChatRoomWidget(
      ChatRoomModel chatRoomModel, UserModel targetUser) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
              chatRoom: chatRoomModel,
              userModel: widget.userModel!,
              targetUser: targetUser,
            ),
          ),
        );
      },
      onLongPress: () {
        _deleteChatRoom(chatRoomModel);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
        width: 344,
        height: 72,
        decoration: const BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: ListTile(
          leading: _buildUserAvatar(targetUser),
          title: _buildUserNameAndTime(targetUser),
          subtitle: _buildLastMessage(chatRoomModel),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(UserModel targetUser) {
    return CircleAvatar(
      backgroundImage: NetworkImage(targetUser.userDpUrl!),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: (targetUser.isOnline!)
              ? ColorResources.online
              : Colors.transparent,
          radius: 7.0,
        ),
      ),
    );
  }

  Widget _buildUserNameAndTime(UserModel targetUser) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          targetUser.userName!,
          style: sansRegular.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorResources.colorPrimary,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        Text(
          targetUser.time!,
          style: sansRegular.copyWith(
            color: ColorResources.chatSubTitle,
            fontSize: Dimensions.fontSizeExtraSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildLastMessage(ChatRoomModel chatRoomModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              chatRoomModel.lastMessage!,
              style: sansRegular.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorResources.chatSubTitle,
                fontSize: Dimensions.fontSizeDefault,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }

  void _deleteChatRoom(ChatRoomModel chatRoomModel) {
    FirebaseFirestore.instance
        .collection(AppConstants.firebaseChatRooms)
        .doc(chatRoomModel.chatRoomId)
        .delete();
    Helpers.showSuccessToast(context, "Chat deleted successfully");
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(child: Text(errorMessage));
  }

  Widget _buildNoChatsWidget() {
    return const Center(
      child: Text("No chats yet. Start chatting with someone!"),
    );
  }
}
