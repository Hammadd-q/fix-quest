import 'package:hip_quest/helper/Helpers.dart';

class BaseController {
  showLoader(context) {
    Helpers.showLoader(context);
  }

  dismissLoader(context) {
    Helpers.dismissLoader(context);
  }
}
