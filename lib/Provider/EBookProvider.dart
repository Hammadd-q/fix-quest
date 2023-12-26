import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/model/response/EbookModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/controller/Controllers.dart';

class EBookProvider extends ChangeNotifier {
  final List<int> authorizedEbooks = [21292, 21291, 21290, 21289, 21283];

  final EbookController ebookController;
  final LearningController learningController;
  final SharedPreferences prefs;

  EBookProvider({
    required this.ebookController,
    required this.learningController,
    required this.prefs,
  });

  List<EbookModel> _ebooks = List.empty(growable: true);

  List<EbookModel> _filteredEbooks = List.empty(growable: true);

  List<EbookModel> get ebooks => _filteredEbooks;

  Future<void> getEbooks(context, callback) async {
    try {
      var userId = prefs.getString(AppConstants.userId);
      print("ebook user id: $userId");
      ApiResponse apiResponse =
          await learningController.getAllLearning(context, userId);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        _filteredEbooks = _ebooks = [];
        List<int> ebookIds = data
            .map((e) =>
                authorizedEbooks.contains(e['post_id']) ? e['post_id'] : null)
            .whereType<int>()
            .toList();
        _ebooks = await Future.wait<EbookModel>(ebookIds.map((ebookId) {
          return ebookController
              .ebook(ebookId, context)
              .then((ApiResponse apiResponse) async {
            var ebookData = apiResponse.response?.data;
            ApiResponse res = await learningController
                .learningMedia(ebookData['featured_media']);
            return EbookModel.fromJson(
                ebookData, res.response?.data['guid']['rendered']);
          });
        }));
        _filteredEbooks = _ebooks;
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

  search(value) {
    if (value == null) {
      _filteredEbooks = _ebooks;
      notifyListeners();
      return;
    }
    _filteredEbooks = [];
    for (var ebook in _ebooks) {
      if (ebook.title.toLowerCase().contains(value.toString().toLowerCase())) {
        _filteredEbooks.add(ebook);
      }
    }
    notifyListeners();
  }
}
