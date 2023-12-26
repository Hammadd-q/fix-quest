import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/data.dart';
import 'package:hip_quest/data/model/response/VideoLibraryModel.dart';
import 'package:hip_quest/data/model/response/meetingmodel.dart';
import '../data/controller/Controllers.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

class VideoLibraryProvider extends ChangeNotifier {
  final VideoLibraryController videoLibraryController;

  VideoLibraryProvider({required this.videoLibraryController});

  List<VideoLibraryModel> _videos = List.empty(growable: true);
  List<MeetingModel> _Meetingvideos = List.empty(growable: true);

  List<VideoLibraryModel> _filteredVideos = List.empty(growable: true);
  List<MeetingModel> _filteredmeetingVideos = List.empty(growable: true);

  List<VideoLibraryModel> get videos => _filteredVideos;

  Future<void> getVideos(context, callback) async {
    try {
      ApiResponse apiResponse =
          await videoLibraryController.videoLibrary(context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _filteredVideos = _videos = [];
        data.forEach((blog) => _videos.add(VideoLibraryModel.fromJson(blog)));
        _filteredVideos = _videos;
        notifyListeners();
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print(errorMessage);
        callback(null, false, errorMessage);
      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  Future<void> getMeetingVideos(context, callback) async {
    try {
      ApiResponse apiResponse =
          await videoLibraryController.meetingLibrary(context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _filteredmeetingVideos = _Meetingvideos = [];
        data.forEach((dynamic blog) {
          if (blog is String) {
            var blogMap = json.decode(blog);
            var meetingModel = MeetingModel.fromJson(blogMap);
            _Meetingvideos.add(meetingModel);
          }
        });

        _filteredmeetingVideos = _Meetingvideos;
        notifyListeners();
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print(errorMessage);
        callback(null, false, errorMessage);
      }
    } catch (e, stackTrace) {
      print(e.toString().replaceAll('Exception:', ''));
      print('Error: $e');
      print('Line number: ${stackTrace.toString()}');
      callback(e.toString().replaceAll('Exception:', ''), false, null);
    }
  }

  search(value) {
    if (value == null) {
      _filteredVideos = _videos;
      notifyListeners();
      return;
    }
    _filteredVideos = [];
    for (var video in _videos) {
      if (video.title.toLowerCase().contains(value.toString().toLowerCase())) {
        _filteredVideos.add(video);
      }
    }
    notifyListeners();
  }

  searchmeeting(value) {
    if (value == null) {
      _filteredmeetingVideos = _Meetingvideos;
      notifyListeners();
      return;
    }
    _filteredmeetingVideos = [];
    for (var video in _Meetingvideos) {
      if (video.title.toLowerCase().contains(value.toString().toLowerCase())) {
        _filteredmeetingVideos.add(video);
      }
    }
    notifyListeners();
  }

  reset() {
    _videos = List.empty(growable: true);
  }
}
