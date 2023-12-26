import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/data/model/chat_room_model.dart';
import 'package:uuid/uuid.dart';

import '../Widgets/GlobalAppBar.dart';
import '../Widgets/TextInput.dart';
import '../data/model/user_model.dart';
import '../util/AppConstants.dart';
import '../util/ColorResources.dart';
import '../util/CustomThemes.dart';
import '../util/Dimensions.dart';

var uuid = const Uuid();

class SearchChatUsers extends StatefulWidget {
  static String routeKey = '/chatusers';

  final UserModel? userModel;

  const SearchChatUsers({Key? key, required this.userModel}) : super(key: key);

  @override
  State<SearchChatUsers> createState() => _SearchChatUsersState();
}

class _SearchChatUsersState extends State<SearchChatUsers> {
  final TextEditingController _searchController = TextEditingController();
  ChatRoomModel? chatRoom = ChatRoomModel();

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(AppConstants.firebaseChatRooms)
        .where("participants.${widget.userModel?.userId}", isEqualTo: true)
        .where("participants.${targetUser.userId}", isEqualTo: true)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      log("ChatRoomModel found");
      var data = querySnapshot.docs[0].data();
      chatRoom = ChatRoomModel.fromMap(data as Map<String, dynamic>);
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel?.userId.toString(): true,
          targetUser.userId: true,
        },
      );

      await FirebaseFirestore.instance
          .collection(AppConstants.firebaseChatRooms)
          .doc(newChatRoom.chatRoomId)
          .set(
            newChatRoom.toMap(),
          )
          .whenComplete(
            () => log("New chat room created"),
          );
      chatRoom = newChatRoom;
    }
    return chatRoom;
  }

  Future<dynamic> toChatRoom(BuildContext context, UserModel searchedUser,
      ChatRoomModel chatRoomModel) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(
          targetUser: searchedUser,
          userModel: widget.userModel!,
          chatRoom: chatRoomModel,
        ),
      ),
    );
  }

  @override
  void initState() {
    _searchController.text = "";
    print("user ${widget.userModel?.toMap()}");
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Search Users'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextInput(
                textName: "Search Here",
                onChanged: (value) => {setState(() {})},
                controller: _searchController,
                icon: const Icon(
                  Icons.search,
                  color: ColorResources.colorPrimary,
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                // dummy data
                initialData: FirebaseFirestore.instance
                    .collection(AppConstants.firebaseUsers)
                    .get(),
                stream: FirebaseFirestore.instance
                    .collection(AppConstants.firebaseUsers)
                    .where("userName", isNotEqualTo: widget.userModel?.userName)
                    .orderBy("userName")
                    .startAt([_searchController.text]).endAt(
                        [_searchController.text + '\uf8ff']).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: ColorResources.colorPrimary,
                    );
                  } else {
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot =
                          snapshot.data as QuerySnapshot;

                      if (querySnapshot.docs.isEmpty) {
                        return Text(
                          "No Results Found",
                          style: sansMedium.copyWith(
                            fontSize: Dimensions.fontSizeMedium,
                            color: ColorResources.colorPrimary,
                          ),
                        );
                      } else {
                        return Flexible(
                          child: ListView.builder(
                            itemCount: querySnapshot.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap =
                                  querySnapshot.docs[index].data()
                                      as Map<String, dynamic>;
                              UserModel searchedUser =
                                  UserModel.fromMap(userMap);

                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 7, right: 10, bottom: 7),
                                width: 344,
                                height: 72,
                                decoration: const BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9)),
                                ),
                                child: ListTile(
                                  onTap: () async {
                                    chatRoom =
                                        await getChatRoomModel(searchedUser);
                                    if (chatRoom != null) {
                                      print("searchedUser $searchedUser");
                                      // ignore: use_build_context_synchronously
                                      toChatRoom(
                                        context,
                                        searchedUser,
                                        chatRoom!,
                                      );
                                    }
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(searchedUser.userDpUrl!),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            (searchedUser.isOnline!)
                                                ? ColorResources.online
                                                : Colors.transparent,
                                        radius: 7.0,
                                      ),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.message,
                                    color: ColorResources.colorPrimary,
                                  ),
                                  title: Text(
                                    searchedUser.userName!,
                                    style: sansRegular.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorResources.colorPrimary,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                  subtitle: Text(
                                    searchedUser.userEmail!,
                                    style: sansRegular.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorResources.colorPrimary,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Text(
                        "No Data",
                        style: sansMedium.copyWith(
                          fontSize: Dimensions.fontSizeMedium,
                          color: ColorResources.colorPrimary,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
