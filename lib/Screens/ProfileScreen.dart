import 'dart:convert';
import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/Providers.dart';
import 'package:hip_quest/Screens/Screens.dart';
import 'package:hip_quest/Widgets/Widgets.dart';
import 'package:hip_quest/helper/Helpers.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeKey = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _occupationController = TextEditingController();
  final _bioController = TextEditingController();
  final _interestController = TextEditingController();

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserInfoProvider>(context, listen: false)
          .setup((firstName, lastName, occupation, bio, interest) {
        _firstNameController.value = TextEditingValue(text: firstName ?? '');
        _lastNameController.value = TextEditingValue(text: lastName ?? '');
        _occupationController.value = TextEditingValue(text: occupation ?? '');
        _bioController.value = TextEditingValue(text: bio ?? '');
        _interestController.value = TextEditingValue(text: interest ?? '');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: ColorResources.colorSecondary,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                Center(
                  child: Text(
                    "Profile Setup",
                    style: sansSemiBold.copyWith(
                      color: ColorResources.black,
                      fontSize: Dimensions.fontSizeMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Consumer<UserInfoProvider>(
                  builder: (_, data, __) {
                    return Stack(
                      children: [
                        Center(
                          child: InkWell(
                            onTap: () {
                              showAdaptiveActionSheet(
                                context: context,
                                title: const Text('Select Option'),
                                androidBorderRadius: 30,
                                actions: <BottomSheetAction>[
                                  BottomSheetAction(
                                    title: const Text('Gallery'),
                                    onPressed: (context) async {
                                      pickImage(ImageSource.gallery,
                                          userInfoProvider);
                                    },
                                  ),
                                  BottomSheetAction(
                                    title: const Text('Camera'),
                                    onPressed: (context) async {
                                      pickImage(
                                          ImageSource.camera, userInfoProvider);
                                    },
                                  ),
                                ],
                                cancelAction: CancelAction(
                                  title: const Text('Cancel'),
                                ),
                              );
                            },
                            child: Container(
                              width: 115.0,
                              height: 115.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: (data.profileImagePath == null)
                                    ? const DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage(ImagesResources.avatar))
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(data.profileImagePath ?? '')),
                                      ),
                              ),
                              child: const Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: ColorResources.colorPrimary,
                                  radius: 17.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                    color: ColorResources.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
                TextInput(
                  textName: "First Name",
                  onChanged: userInfoProvider.setFirstName,
                  controller: _firstNameController,
                ),
                const SizedBox(height: 12),
                TextInput(
                  textName: "Last Name",
                  onChanged: userInfoProvider.setLastName,
                  controller: _lastNameController,
                ),
                const SizedBox(height: 12),
                TextInput(
                  textName: "Occupation",
                  onChanged: userInfoProvider.setOccupation,
                  controller: _occupationController,
                ),
                const SizedBox(height: 12),
                TextInput(
                  textName: "Bio",
                  onChanged: userInfoProvider.setBio,
                  controller: _bioController,
                ),
                const SizedBox(height: 12),
                TextInput(
                  textName: "Interests",
                  onChanged: userInfoProvider.setInterests,
                  controller: _interestController,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  onPress: () {
                    userInfoProvider.update(context, responseHandler);
                  },
                  text: "Next",
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              MainScreen.routeKey, (route) => false),
                      child: Text(
                        "Skip",
                        style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  responseHandler(isVerified, errorMessage) {
    if (!isVerified) return Helpers.showErrorToast(context, errorMessage);
    Helpers.showSuccessToast(
        context, "User Profile has been updated Successfully!");
    Navigator.pushNamed(context, MainScreen.routeKey);
  }

  pickImage(source, UserInfoProvider userInfoProvider) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: ColorResources.colorPrimary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        userInfoProvider.setProfileImage(
            base64.encode(await image.readAsBytes()), croppedFile.path);
      }
    }
    Navigator.pop(context);
  }
}
