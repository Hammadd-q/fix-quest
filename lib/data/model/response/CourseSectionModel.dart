class CourseSectionModel {
  final int id;
  final String title;
  final String body;
  final String image;

  CourseSectionModel(this.id, this.title, this.body, this.image);

  static CourseSectionModel fromJson(data, image) {
    return CourseSectionModel(
      data['id'] ?? 0,
      data['title']['rendered'] ?? '',
      data['content']['rendered'] ?? '',
      image ?? '',
    );
  }
}
