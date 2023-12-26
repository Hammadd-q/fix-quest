class VideoLibraryModel {
  int id;
  String title;
  String date;
  String content;
  String excerpt;
  String videoUrl;
  String webview_video_url;
  String videoThumbnail;

  VideoLibraryModel(this.id,
      this.title,
      this.date,
      this.content,
      this.excerpt,
      this.videoUrl,
      this.webview_video_url,
      this.videoThumbnail,);

  static VideoLibraryModel fromJson(Map<String, dynamic> json) {
    return VideoLibraryModel(
      json['ID'],
      json['title'],
      json['date'],
      json['Content'],
      json['excerpt'],
      // json['video_url']?[0] ?? json['video_url'] ?? '',
      // json['webview_video_url']?[0] ?? json['webview_video_url'] ?? '',
      json['video_url'],
      json['webview_video_url'],
      json['video_thumbnail'],
    );
  }

  toJson() {
    return {
      'ID': id,
      'title': title,
      'date': date,
      'Content': content,
      'excerpt': excerpt,
      'video_url': videoUrl,
      'webview_video_url': webview_video_url,
      'video_thumbnail': videoThumbnail,
    };
  }
}
