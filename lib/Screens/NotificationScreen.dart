import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/AppConstants.dart';
import '../util/Utils.dart';

class NotificationScreen extends StatefulWidget {
  static String routeKey = '/notification';

  String? currentUserEmail;

  NotificationScreen({Key? key, required this.currentUserEmail})
      : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Notification'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(AppConstants.firebaseNotifications)
                    .doc(widget.currentUserEmail)
                    .collection(widget.currentUserEmail!)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.colorPrimary,
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          trailing: Text(snapshot.data?.docs[index]['time'],
                              style: sansRegular.copyWith(
                                color: ColorResources.chatSubTitle,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              )),
                          title: Text(snapshot.data?.docs[index]['title'],
                              style: sansRegular.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorResources.colorPrimary,
                                fontSize: Dimensions.fontSizeDefault,
                              )),
                          subtitle: Text(snapshot.data?.docs[index]['body'],
                              style: sansRegular.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorResources.colorPrimary,
                                fontSize: Dimensions.fontSizeDefault,
                              )),
                          leading: const SizedBox(
                            width: 56,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: ColorResources.colorPrimary,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage(ImagesResources.skeleton),
                              ),
                            ),
                          ),
                        );
                      });
                })),
      ),
    );
  }
}
