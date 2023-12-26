class CourseModel {
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final String image;

  CourseModel(this.id, this.title, this.body, this.image, this.createdAt);

  static CourseModel fromJson(data, image) {
    return CourseModel(
      data['id'] ?? 0,
      data['title']['rendered'] ?? '',
      data['content']['rendered'] ?? '',
      image ?? '',
      data['date_created'].toString().split(' ').first,
    );
  }
}
