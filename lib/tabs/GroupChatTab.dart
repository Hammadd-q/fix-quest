import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/data/model/DummyChat.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';
import '../Screens/Screens.dart';

class GroupChatTab extends StatefulWidget {
  const GroupChatTab({Key? key}) : super(key: key);

  @override
  State<GroupChatTab> createState() => _GroupChatTabState();
}

class _GroupChatTabState extends State<GroupChatTab> {
  bool isExist = false;

  bool hasChat(BuildContext context, int index) {
    if (groupdummyData[index].chatNumber == "0") {
      isExist = true;
    } else {
      isExist = false;
    }
    return isExist;
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
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 16.0, 0.0),
              child: Divider(
                height: 2.0,
              ),
            );
          },
          itemCount: groupdummyData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                log(groupdummyData[index].name);
                Navigator.pushNamed(context, GroupChatRoomScreen.routeKey);
              },
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
                width: 344,
                height: 72,
                decoration:  const BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                child: ListTile(

                  leading: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 15.0,
                              height: 15.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(ImagesResources.avatar)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 15.0,
                              height: 15.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(ImagesResources.avatar)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 15.0,
                              height: 15.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(ImagesResources.avatar)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 15.0,
                              height: 15.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(ImagesResources.avatar)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      groupdummyData[index].name,
                      style: sansRegular.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorResources.colorPrimary,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ),
                )


              ),
            );
          },
        ),
      ),
    );
  }
}
