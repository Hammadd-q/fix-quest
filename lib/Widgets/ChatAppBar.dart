import 'package:flutter/material.dart';
import 'package:hip_quest/util/AppConstants.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';


class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? onlineStatus;
  //final String? avatar;
  final bool backButton;

  const ChatAppBar({
    Key? key,
    required this.title,
    required this.onlineStatus,
    //required this.avatar,
    this.backButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: ColorResources.colorPrimary,
            ),
          ),
          CircleAvatar(radius: (21),
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(21),
                child: Image.asset(ImagesResources.applogo),
              )
          ),
          const SizedBox(width: 20.0 * 0.75),
          Text(
            title!,
            style: sansLight.copyWith(
              color:  ColorResources.black,
              fontSize: Dimensions.fontSizeSmall,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
