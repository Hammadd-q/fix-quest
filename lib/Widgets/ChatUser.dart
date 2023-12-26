import 'dart:developer';

import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/data/model/response/ChatUsersModel.dart';
import 'package:hip_quest/util/Utils.dart';

class ChatUser extends StatelessWidget {
  final ChatUsersModel user;

  const ChatUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, ChatUserViewScreen.routeKey);
        log("Chat user");
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
        width: 344,
        height: 70,
        decoration: const BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          trailing: const Icon(
            Icons.chat,
            color: ColorResources.colorPrimary,
          ),
          leading: const AvatarView(
            radius: 20,
            borderWidth: 1,
            borderColor: ColorResources.colorPrimary,
            avatarType: AvatarType.CIRCLE,
            backgroundColor: ColorResources.white,
            imagePath: ImagesResources.avatar,
            placeHolder: Icon(
              Icons.person,
              size: 50,
            ),
            errorWidget: Icon(
              Icons.error,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
