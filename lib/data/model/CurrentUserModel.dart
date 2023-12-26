class CurrentUserModel {
   String? id;
   String? email;
   String? firstname;
   String? lastname;
   String? profile;
   String? fcmKey;
   bool? online;
   DateTime? createdon;


   CurrentUserModel(this.id, this.email, this.firstname, this.lastname,
       this.profile, this.fcmKey, this.online, this.createdon);

   CurrentUserModel.fromMap(Map<String, dynamic> map) {

     id = map["id"];
     email = map["email"];
     firstname = map["firstname"];
     lastname = map["lastname"];
     profile = map["profile"];
     fcmKey = map["fcmKey"];
     online = map["online"];
     createdon = map["createdon"].toDate();

   }
  // @override
  // String toString() {
  //   return 'Current User: {id: $id, email: $email,firstname: $firstname,lastname: $lastname, profile: $profile,fcmKey: $fcmKey, status: $status}';
  // }


  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'userEmail': email,
      'userFName': firstname,
      'userLName': lastname,
      'userProfile': profile,
      'userFcmKey': fcmKey,
      "online": online,
      "createdon": createdon
    };
  }

}
