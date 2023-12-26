import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/model/response/CourseDetailModel.dart';
import 'package:hip_quest/data/model/response/CourseModel.dart';
import 'package:hip_quest/data/model/response/CourseSectionModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controller/Controllers.dart';
import '../util/AppConstants.dart';

class CourseProvider extends ChangeNotifier {
  final CourseController courseController;
  final LearningController learningController;
  final SharedPreferences prefs;

  CourseProvider({
    required this.courseController,
    required this.learningController,
    required this.prefs,
  });

  List<CourseModel> _courses = List.empty(growable: true);

  List<CourseModel> get courses => _courses;

  CourseDetailModel? _course;

  CourseDetailModel? get course => _course;

  CourseSectionModel? _courseSection;

  CourseSectionModel? get courseSection => _courseSection;

  Future<void> getCourses(context, callback) async {
    try {
      var userId = prefs.getString(AppConstants.userId);
      ApiResponse apiResponse =
          await learningController.getAllLearning(context, userId);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        List<int> courseIds = data
            .map((e) => e['_links']['post'].first['type'] == 'course'
                ? e['post_id']
                : null)
            .whereType<int>()
            .toList();
        _courses = await Future.wait<CourseModel>(courseIds.map((courseId) {
          return courseController
              .courseDetail(courseId, context)
              .then((ApiResponse apiResponse) async {
            var courseData = apiResponse.response?.data;
            ApiResponse res = await learningController
                .learningMedia(courseData['featured_media']);
            return CourseModel.fromJson(
                courseData, res.response?.data['guid']['rendered']);
          });
        }));
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
      callback(null, false, e.toString().replaceAll('Exception:', ''));
    }
  }

  Future<void> getCourse(context, courseId, index) async {
    try {
      var selectedCourse = _courses[index];
      var userId = 17;
      ApiResponse res =
          await courseController.courseProgress(userId, courseId, context);
      ApiResponse sectionsRes =
          await courseController.courseSections(courseId, context);
      List<int> sectionIds = sectionsRes.response?.data
          .map((e) => e['id'])
          .whereType<int>()
          .toList();
      List<CourseSectionModel> courseSections =
          await Future.wait<CourseSectionModel>(sectionIds.map((sectionId) {
        return courseController
            .courseSection(sectionId, context)
            .then((ApiResponse apiResponse) async {
          var sectionData = apiResponse.response?.data[0];
          ApiResponse res = await learningController
              .learningMedia(sectionData['featured_media']);
          return CourseSectionModel.fromJson(
              sectionData, res.response?.data['guid']['rendered']);
        });
      }));
      int progress = res.response?.data['progress'];
      _course = CourseDetailModel(
        selectedCourse.id,
        selectedCourse.title,
        selectedCourse.body,
        selectedCourse.image,
        selectedCourse.createdAt,
        progress,
        courseSections,
      );
      notifyListeners();
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  selectSection(CourseSectionModel? courseSection) {
    _courseSection = courseSection;
    notifyListeners();
  }

}
