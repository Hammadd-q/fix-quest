
import 'package:flutter/foundation.dart';
import 'package:hip_quest/data/model/response/FreeResourceModel.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';

import '../data/controller/Controllers.dart';

class FreePdfProvider extends ChangeNotifier {
  final FreePdfController freePdfController;

  FreePdfProvider({required this.freePdfController});

  List<FreeResourceModel> _freeResources = List.empty(growable: true);
  List<FreeResourceModel> get freeResources => _freeResources;

  FreeResourceModel? _freeResource;

  FreeResourceModel? get freeResource => _freeResource;

  Future<void> getFreeResource(context,callback) async {
    try {
      ApiResponse apiResponse = await freePdfController.freeResource(context);
      if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
        var data = apiResponse.response?.data;
        data.forEach((freeResource) => _freeResources.add(FreeResourceModel.fromJson(freeResource)));
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
        callback(null, false,errorMessage);

      }
    } catch (e) {
      print(e.toString().replaceAll('Exception:', ''));
    }
  }


  reset() {
    _freeResources = List.empty(growable: true);
  }
}
