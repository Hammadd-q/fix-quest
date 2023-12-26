import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/model/response/EventModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

import '../data/controller/Controllers.dart';

class EventProvider extends ChangeNotifier {
  final EventController eventController;

  EventProvider({required this.eventController});

  List<EventModel> _events = List.empty(growable: true);
  List<EventModel> get events => _events;

  EventModel? _event;

  EventModel? get event => _event;

  Future<void> getEvents(context, callback) async {
    try {
      ApiResponse apiResponse = await eventController.events(context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;

        _events = [];
        data.forEach((blog) => _events.add(EventModel.fromJson(blog)));
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
        callback(null, false, errorMessage);
      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }

  Future<void> getSingleEvent(context, eventId) async {
    try {
      _event = null;
      notifyListeners();
      ApiResponse apiResponse = await eventController.event(eventId, context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _event = EventModel.fromJson(data);
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
    _events = List.empty(growable: true);
  }
}
