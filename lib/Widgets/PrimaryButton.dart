import 'package:flutter/material.dart';
import 'package:hip_quest/util/Utils.dart';


class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String text;
  final bool margin;
  final double height;
  final double fontSize;
  final bool primaryColor;
  final bool disabled;

  const PrimaryButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.margin = true,
    this.disabled = false,
    this.height = 60,
    this.fontSize = Dimensions.fontSizeExtraLarge,
    this.primaryColor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onPress,
      child: Container(
        // width: 374,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: ColorResources.colorPrimary.withOpacity(disabled ? .5 : 1),
        ),
        child: Center(
          child: Text(
            text,
            style: sansMedium.copyWith(
              color: ColorResources.colorSecondary,
              fontSize: fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
