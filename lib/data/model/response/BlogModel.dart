class BlogModel {
  final int id;
  final String title;
  final String image;
  final String body;
  final String date;

  BlogModel(this.id, this.title, this.body, this.image, this.date);

  static BlogModel fromJson(data) {
    return BlogModel(
      data['ID'] ?? data['id'] ?? '',
      data['Title'] ?? data['title'] ?? '',
      data['Content'] ?? '',
      data['post_img'] ?? data['featured_img_src'] ?? '',
      data['Date'] ?? ''
    );
  }
}
