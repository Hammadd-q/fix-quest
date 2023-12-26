class GroupMessageModel {

  String? sender;
  String? name;
  String? text;
  String? profileUrl;
  bool? seen;
  bool? online;
  DateTime? createdon;

  GroupMessageModel( this.sender, this.name, this.text, this.profileUrl,
      this.seen, this.online, this.createdon);


  GroupMessageModel.fromMap(Map<String, dynamic> map) {

    sender = map["sender"];
    name = map["name"];
    text = map["text"];
    profileUrl = map["profileUrl"];
    seen = map["seen"];
    online = map["online"];
    createdon = map["createdon"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {

      "sender": sender,
      "name": name,
      "text": text,
      "profileUrl": profileUrl,
      "seen": seen,
      "online": online,
      "createdon": createdon
    };
  }
}