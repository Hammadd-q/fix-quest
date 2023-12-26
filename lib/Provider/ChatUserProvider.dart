import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/model/response/ChatUsersModel.dart';
import '../data/controller/Controllers.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

class ChatUserProvider extends ChangeNotifier {
  final ChatUserController chatUserController;

  ChatUserProvider({required this.chatUserController});

  List<ChatUsersModel> _chatUsers = List.empty(growable: true);
  List<ChatUsersModel> get chatUsers => _chatUsers;

  Future<void> getUsers(context) async {
    try {
      ApiResponse apiResponse = await chatUserController.chatUsers(context);
      if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        data.forEach((blog) => _chatUsers.add(ChatUsersModel.fromJson(blog)));
        notifyListeners();
      } else {
        String? errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  reset() {
    _chatUsers = List.empty(growable: true);
  }
}
