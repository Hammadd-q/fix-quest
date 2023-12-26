class FreeResourceModel {
  int iD;
  String title;
  String date;
  String pdfUrl;

  FreeResourceModel(this.iD, this.title, this.date, this.pdfUrl);

  static FreeResourceModel fromJson(Map<String, dynamic> json) {
    return FreeResourceModel(
      json['ID'],
      json['title'],
      json['date'],
      json['pdf_url'],
    );
  }
}
