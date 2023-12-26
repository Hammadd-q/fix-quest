class MeetingModel {
  int id;
  String title;
  String content;
  List<RecordingModel> recordings;

  MeetingModel({
    required this.id,
    required this.title,
    required this.content,
    required this.recordings,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    List<RecordingModel> recordings = <RecordingModel>[];
    if (json['meeting_recordings'] != null) {
      for (var recording in json['meeting_recordings']) {
        recordings.add(RecordingModel.fromJson(recording));
      }
    }

    return MeetingModel(
      id: json['ID'],
      title: json['title'],
      content: json['content'],
      recordings: recordings,
    );
  }
}

class RecordingModel {
  int id;
  String title;
  String about;
  List<SessionModel> sessions;

  RecordingModel({
    required this.id,
    required this.title,
    required this.about,
    required this.sessions,
  });

  factory RecordingModel.fromJson(Map<String, dynamic> json) {
    List<SessionModel> sessions = <SessionModel>[];
    if (json['recordings'] != null) {
      for (var session in json['recordings']) {
        sessions.add(SessionModel.fromJson(session));
      }
    }

    return RecordingModel(
      id: json['ID'],
      title: json['title'],
      about: json['about'],
      sessions: sessions,
    );
  }
}

class SessionModel {
  String session;
  String webviewVideoUrl;

  SessionModel({
    required this.session,
    required this.webviewVideoUrl,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      session: json['session'],
      webviewVideoUrl: json['webview_video_url'],
    );
  }
}
