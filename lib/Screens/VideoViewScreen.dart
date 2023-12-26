import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:vimeo_video_player/vimeo_video_player.dart';

import '../util/Utils.dart';
class VideoViewScreen extends StatefulWidget {
  static String routeKey = '/blogsview';
  final String url;


  const VideoViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.colorSecondary,
      body: SafeArea(
        child: VimeoVideoPlayer(
          vimeoPlayerModel: VimeoPlayerModel(
            url: widget.url,
            deviceOrientation: DeviceOrientation.portraitUp,
            systemUiOverlay: const [
              SystemUiOverlay.top,
              SystemUiOverlay.bottom,
            ],
          ),
        ),
      ),
    );
  }
}
