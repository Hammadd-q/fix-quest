import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hip_quest/data/model/response/VideoLibraryModel.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/Widgets.dart';
import '../util/ColorResources.dart';

class FavouriteScreen extends StatefulWidget {
  static String routeKey = '/favourite';

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var videoList = [];


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> videos = jsonDecode(prefs.getString(AppConstants.favoriteVideos) ?? '[]');
      var videosList = videos.values.map((v) => VideoLibraryModel.fromJson(v)).toList();
      setState(() {
        videoList = videosList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: ColorResources.colorSecondary,
      appBar: const GlobalAppBar(title: 'Favourite Items'),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              return Videos(video: videoList[index], hideFavorite: true);
            },
          ),
        ),
      ),
    );
  }
}
