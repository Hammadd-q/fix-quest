import 'package:flutter/material.dart';
import 'package:hip_quest/util/Utils.dart';

class DashboardBox extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPress;

  const DashboardBox({
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          color: ColorResources.colorPrimary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(icon),
              color: ColorResources.white,
              width: 33.0,
              height: 33.0,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: sansSemiBold.copyWith(
                color: ColorResources.white,
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
