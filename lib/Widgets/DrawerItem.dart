import 'package:flutter/material.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/CustomThemes.dart';
import 'package:hip_quest/util/Dimensions.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorResources.white,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: sansRegular.copyWith(
                fontSize: Dimensions.fontSizeMedium,
                color: ColorResources.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
