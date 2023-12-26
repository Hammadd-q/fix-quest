import 'package:flutter/material.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoCategory {
  final int id;
  final String name;
  final String slug;
  final String description;
  final int count;
  final String image;

  VideoCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.count,
    required this.image,
  });
}

class Video {
  final int id;
  final String title;
  final String date;
  final String content;
  final String excerpt;
  final String videoUrl;
  final String videoThumbnail;

  Video({
    required this.id,
    required this.title,
    required this.date,
    required this.content,
    required this.excerpt,
    required this.videoUrl,
    required this.videoThumbnail,
  });
}

class VideoLibraryScreen extends StatefulWidget {
  static String routeKey = '/videolibrary';
  @override
  _VideoLibraryScreenState createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  List<VideoCategory> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://dralisongrimaldi.com/wp-json/md-api/video_library?user_id=$userid'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['error'] == 0) {
        final categoryData = data['data'] as List<dynamic>;

        setState(() {
          categories = categoryData
              .map((categoryJson) => VideoCategory(
                    id: categoryJson['id'],
                    name: categoryJson['name'],
                    slug: categoryJson['slug'],
                    description: categoryJson['description'],
                    count: categoryJson['count'],
                    image: categoryJson['image'] ?? "",
                  ))
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: sansSemiBold.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                ),
                text: "Video",
              ),
              TextSpan(
                style: sansLight.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeOverLarge,
                  fontWeight: FontWeight.w300,
                ),
                text: "library",
              )
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.colorPrimary,
          ),
        ),
      ),
      body: categories.isEmpty
          ? Column(
              children: [
                Spacer(),
                Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.colorPrimary,
                  ),
                ),
                Spacer()
              ],
            )
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideosScreen(
                                categorySlug: category.id.toString(),
                                title: category.slug,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              color: ColorResources.white,
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                category.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.withOpacity(0.6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text(category.name,
                                          style: sansSemiBold.copyWith(
                                            color: ColorResources.darkGrey,
                                            fontSize: Dimensions.fontSizeLarge,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class VideosScreen extends StatefulWidget {
  final String title;
  final String categorySlug;

  VideosScreen({required this.categorySlug, required this.title});

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  List<Video> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    print(
        'https://dralisongrimaldi.com/wp-json/md-api/video_library/${widget.categorySlug}?user_id=$userid');
    final response = await http.get(Uri.parse(
        'https://dralisongrimaldi.com/wp-json/md-api/video_library/${widget.categorySlug}?user_id=$userid'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['error'] == 0) {
        final videoData = data['data'] as List<dynamic>;

        setState(() {
          videos = videoData
              .map((videoJson) => Video(
                    id: videoJson['ID'],
                    title: videoJson['title'],
                    date: videoJson['date'],
                    content: videoJson['Content'],
                    excerpt: videoJson['excerpt'],
                    videoUrl: videoJson['webview_video_url'],
                    videoThumbnail: videoJson['video_thumbnail'] ?? "",
                  ))
              .toList();

          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                style: sansRegular.copyWith(
                  color: ColorResources.colorPrimary,
                  fontSize: Dimensions.fontSizeDefault,
                ),
                text: widget.title,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.colorPrimary,
          ),
        ),
      ),
      body: isLoading
          ? Column(
              children: [
                Spacer(),
                Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.colorPrimary,
                  ),
                ),
                Spacer()
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorResources.successStatus)),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: WebView(
                          initialUrl: video.videoUrl,
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageFinished: (finish) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Html(data: video.content),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }

  void _launchVideoUrl(String videoUrl) async {
    // if (await canLaunch(videoUrl)) {
    //   await launch(videoUrl);
    // } else {
    //   // Handle the error if the URL can't be launched
    //   // For example, display a dialog or show a message to the user
    // }
  }
}
