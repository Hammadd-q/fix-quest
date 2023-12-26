import 'package:hip_quest/data/model/response/CourseSectionModel.dart';

class CourseDetailModel {
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final String image;
  final int progress;
  final List<CourseSectionModel> courseSections;

  CourseDetailModel(this.id, this.title, this.body, this.image, this.createdAt, this.progress, this.courseSections);

  static CourseDetailModel fromJson(data, image, progress, courseSections) {
    return CourseDetailModel(
      data['id'] ?? 0,
      data['title']['rendered'] ?? '',
      data['content']['rendered'] ?? '',
      image ?? '',
      data['date_created'].toString().split(' ').first,
      progress,
      courseSections,
    );
  }
}
