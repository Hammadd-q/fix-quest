import 'dart:convert';
import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Screens/VideoViewScreen.dart';
import 'package:hip_quest/data/model/response/VideoLibraryModel.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Screens.dart';

class Videos extends StatefulWidget {
  final VideoLibraryModel video;
  final bool hideFavorite;

  const Videos({
    Key? key,
    required this.video,
    this.hideFavorite = false,
  }) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  bool isFavorite = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      var videos = prefs.getString(AppConstants.favoriteVideos);
      videos ??= '{}';
      var videosArray = jsonDecode(videos);
      isFavorite = videosArray["videos-${widget.video.id}"] != null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        print("Video: ${json.encode(widget.video)}");
       // Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoViewScreen(url: widget.video.webview_video_url)));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  WebviewScreen(
                url: widget.video.webview_video_url,
                title: widget.video.title,
              ),
            ));
      }

      ,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .20,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.video.videoThumbnail),
                fit: BoxFit.cover,
              ),
            ),
            child: BlurryContainer(
              blur: 1,
              height: MediaQuery.of(context).size.height * .20,
              width: double.infinity,
              elevation: 0,
              color: ColorResources.black.withOpacity(0.4),
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.video.title,
                  style: sansMedium.copyWith(
                    fontSize: Dimensions.fontSizeMedium,
                    color: ColorResources.white,
                  ),
                ),
              ),
            ),
          ),
          if (!widget.hideFavorite)
            Positioned(
              right: 5.0,
              top: 10.0,
              child: IconButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  var videos = prefs.getString(AppConstants.favoriteVideos);
                  videos ??= '{}';
                  Map<String, dynamic> videosArray = jsonDecode(videos);
                  var videoIndex = "videos-${widget.video.id}";
                  if (videosArray[videoIndex] == null) {
                    videosArray[videoIndex] = widget.video.toJson();
                    setState(() {
                      isFavorite = true;
                    });
                  } else {
                    videosArray.remove(videoIndex);
                    setState(() {
                      isFavorite = false;
                    });
                  }
                  await prefs.setString(AppConstants.favoriteVideos, jsonEncode(videosArray));
                },
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? ColorResources.colorPrimary : ColorResources.white,
                  size: 30,
                ),
              ),
            )
        ],
      ),
    );
  }
}
