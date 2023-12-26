class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final String chatNumber;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.chatNumber
  });
}

List<ChatModel> dummyData = [
  ChatModel(
      name: "Francis",
      message: "charley, the bet spoil",
      time: "03:15 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2016/08/02/22/02/child-1565202_960_720.jpg",
      chatNumber: "1"
  ),
  ChatModel(
      name: "Nana Tuga",
      message: "send me the linode server credentials ",
      time: "01:02 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2016/02/19/11/19/computer-1209641_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "Emmanuel",
      message: "thanks for the book ",
      time: "04:35 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2015/06/08/14/56/person-801789_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "James",
      message: "wossop? ",
      time: "11:15 am",
      avatarUrl: "https://images.unsplash.com/photo-1520634222887-a2baa539fab3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80",
      chatNumber: "2"
  ),
  ChatModel(
      name: "Mimi",
      message: "charliey boombar tonight?",
      time: "05:42 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/02/16/23/10/smile-2072907_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "Nat",
      message: "Hello",
      time: "03:15 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2016/04/15/23/39/african-wild-dog-1332236_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "Elikplim",
      message: "thanks bro",
      time: "03:15 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2016/07/24/06/38/guitar-1537991_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "Mavis",
      message: "pick my call",
      time: "03:15 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/08/03/22/39/african-child-2578559_960_720.jpg",
      chatNumber: "0"
  ),
  ChatModel(
      name: "Samuel AiT",
      message: "Call me",
      time: "03:15 pm",
      avatarUrl: "https://cdn.pixabay.com/photo/2017/08/06/09/50/sweet-2590794_960_720.jpg",
      chatNumber: "0"
  ),
];

List<ChatModel> groupdummyData = [
  ChatModel(
      name: "Team Announcement",
      message: "",
      time: "",
      avatarUrl: "https://cdn.pixabay.com/photo/2016/08/02/22/02/child-1565202_960_720.jpg",
      chatNumber: ""
  )
];