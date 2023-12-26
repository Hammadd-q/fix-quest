import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hip_quest/Provider/BaseProvider.dart';
import 'package:hip_quest/data/controller/Controllers.dart';
import 'package:hip_quest/data/model/ValidationItem.dart';
import 'package:hip_quest/data/model/response/base/ApiResponse.dart';
import 'package:hip_quest/data/model/response/base/ErrorResponse.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoProvider extends BaseProvider {
  final UserInfoController userInfoController;
  final LoginController loginController;
  final SharedPreferences prefs;

  UserInfoProvider({
    required this.userInfoController,
    required this.loginController,
    required this.prefs,
  });

  String _id = "";
  ValidationItem _firstName = ValidationItem(null, "First Name Required");
  ValidationItem _lastName = ValidationItem(null, "Last Name Required");
  ValidationItem _bio = ValidationItem(null, "Bio Required");
  ValidationItem _occupation = ValidationItem(null, "Occupation Required");
  String? _profileImage;
  String? _newImage;
  String? _profileImagePath;
  ValidationItem _interests = ValidationItem(null, "Interests Required");

  ValidationItem get firstName => _firstName;

  ValidationItem get lastName => _lastName;

  ValidationItem get bio => _bio;

  ValidationItem get occupation => _occupation;

  String? get profileImage => _profileImage;

  String? get profileImagePath => _profileImagePath;

  ValidationItem get interests => _interests;

  String? get newImage => _newImage;

  void setFirstName(String value) {
    _firstName = ValidationItem(null, "First Name is not valid");

    if (value != '') {
      _firstName = ValidationItem(value, null);
    }
  }

  void setLastName(String value) {
    _lastName = ValidationItem(null, "Last Name is not valid");
    if (value != '') {
      _lastName = ValidationItem(value, null);
    }
  }

  void setBio(String value) {
    _bio = ValidationItem(null, "Bio is not valid");
    if (value != '') {
      _bio = ValidationItem(value, null);
    }
  }

  void setOccupation(String value) {
    _occupation = ValidationItem(null, "Occupation is not valid");
    if (value != '') {
      _occupation = ValidationItem(value, null);
    }
  }

  void setProfileImage(String value, String path) {
    _profileImage = value;
    _profileImagePath = path;
    notifyListeners();
  }

  void setInterests(String value) {
    _interests = ValidationItem(null, "Interests is not valid");
    if (value != '') {
      _interests = ValidationItem(value, null);
    }
  }

  Future<void> setup(
      Function(String?, String?, String?, String?, String?) callback) async {
    final url = Uri.parse(
        'https://dralisongrimaldi.com/wp-json/md-api/users/profile/${prefs.getString(AppConstants.userId)}');

    final response = await http.post(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["data"]);
      var prefs = await SharedPreferences.getInstance();
      _id = jsonResponse["data"]["ID"].toString() ?? "";
      var firstName = jsonResponse["data"]["first_name"];
      var lastName = jsonResponse["data"]["last_name"];
      var occupation = jsonResponse["data"]["occupation"];
      var bio = jsonResponse["data"]["bio"];
      var interest = jsonResponse["data"]["intrest"];

      setFirstName(firstName ?? '');
      setLastName(lastName ?? '');
      setOccupation(occupation ?? '');
      setBio(bio ?? '');
      setInterests(interest ?? '');
      callback(firstName, lastName, occupation, bio, interest);
    }
  }

  Future<void> update(context, callback) async {
    try {
      validate();
      var profileData = {
        'user_id': _id,
        'first_name': firstName.value,
        'last_name': lastName.value,
        'bio': bio.value,
        'occupation': occupation.value,
        'intrest': interests.value,
        'image_change': _profileImage != null,
        'profile_img': _profileImage,
      };
      print("profileData update: $profileData");

      var prefs = await SharedPreferences.getInstance();
      String currentUserEmail = prefs.getString(AppConstants.userEmail) ?? "";

      bool? deviceCheck;
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceCheck = androidInfo.isPhysicalDevice;
        print('Is emulator: ${androidInfo.isPhysicalDevice}');
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceCheck = iosInfo.isPhysicalDevice;
        print('Is simulator: ${iosInfo.isPhysicalDevice}');
      }

      await FirebaseFirestore.instance
          .collection(AppConstants.firebaseUsers)
          .doc(_id)
          .update({"isOnline": "Not Active"});

      ApiResponse apiResponse =
          await userInfoController.update(profileData, context);
      if (apiResponse.response != null &&
          apiResponse.response?.statusCode == 200) {
        var image = apiResponse.response?.data['img_url'] ?? '';
        if (image is String && image != '') {
          await prefs.setString(
              AppConstants.profileImage, apiResponse.response?.data['img_url']);
          _newImage = image;
          notifyListeners();
        }
        callback(true, null);
      } else {
        String? errorMessage;
        print(apiResponse.error);
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          ErrorResponse errorResponse = apiResponse.error;
          errorMessage = errorResponse.errors[0];
        }
        print("UserInfoProvider$errorMessage");
        callback(false, errorMessage);
      }
    } catch (e) {
      print(e);
      callback(false, e.toString().replaceAll('Exception:', ''));
    }
  }

  void validate() {
    if (firstName.error != null) {
      throw Exception(firstName.error);
    }
    if (lastName.error != null) {
      throw Exception(lastName.error);
    }
    if (bio.error != null) {
      throw Exception(bio.error);
    }
    if (occupation.error != null) {
      throw Exception(occupation.error);
    }
    if (interests.error != null) {
      throw Exception(interests.error);
    }
  }
}
