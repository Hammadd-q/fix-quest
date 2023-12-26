class EbookModel {
  final int id;
  final String title;
  final String image;
  final String body;

  EbookModel(this.id, this.title, this.body, this.image);

  static EbookModel fromJson(data, image) {
    return EbookModel(
      data['id'] ?? 0,
      data['title']['rendered'] ?? '',
      data['content']['rendered'] ?? '',
      image ?? '',
    );
  }
}
