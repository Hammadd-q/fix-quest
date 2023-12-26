import 'package:flutter/material.dart';
import 'package:hip_quest/Provider/UserInfoProvider.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool avatar;
  final bool backButton;
  final String? profileImage;

  const GlobalAppBar({
    Key? key,
    this.title,
    this.avatar = false,
    this.backButton = true,
    this.profileImage,
  }) : super(key: key);

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: title != null
          ? Text(
              title!,
              style: sansMedium.copyWith(
                color: ColorResources.colorPrimary,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    style: sansSemiBold.copyWith(
                      color: ColorResources.colorPrimary,
                      fontSize: Dimensions.fontSizeOverLarge,
                    ),
                    text: "Hip",
                  ),
                  TextSpan(
                    style: sansLight.copyWith(
                      color: ColorResources.colorPrimary,
                      fontSize: Dimensions.fontSizeOverLarge,
                      fontWeight: FontWeight.w300,
                    ),
                    text: "Quest",
                  )
                ],
              ),
            ),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: true,
      leading: backButton ? const BackIcon() : const MenuIcon(),
      actions: [
        if (avatar)
          Consumer<UserInfoProvider>(builder: (_, data, __) {
            var image = data.newImage ?? profileImage;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: image != null && image != ''
                  ? CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(image),
                      backgroundColor: Colors.transparent,
                    )
                  : Image.asset(ImagesResources.avatar, width: 42, height: 42),
            );
          }),
      ],
    );
  }
}

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back,
        color: ColorResources.colorPrimary,
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  const MenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(
        Icons.widgets,
        color: ColorResources.colorPrimary,
      ),
    );
  }
}
