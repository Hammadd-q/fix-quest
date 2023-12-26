class EventModel {
  int id;
  String title;
  String startDate;
  String currency;
  String cost;
  String body;
  String featuredImgSrc;
  String event_link;

  EventModel(
    this.id,
    this.title,
    this.startDate,
    this.currency,
    this.cost,
    this.body,
    this.featuredImgSrc,
    this.event_link,
  );

  static EventModel fromJson(data) {
    return EventModel(
      data['ID'] ?? data['id'] ?? '',
      data['title'] ?? '',
      data['start_date']?[0] ?? '',
      data['currency'] ?? '',
      data['cost'].length > 0 ? data['cost'][0] ?? '' : '',
      data['content'] ?? '',
      data['featured_img_src'] ?? data['featured_img'] ?? '',
      data['event_link'] ?? data['event_link'] ?? '',
    );
  }
}
