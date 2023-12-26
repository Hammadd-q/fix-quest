import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  final String textName;
  final Widget? icon;
  final Widget? prefixIcon;
  final String type;
  final bool center;
  final bool margin;
  final FocusScopeNode? node;
  final MaskTextInputFormatter? maskFormatter;
  final int maxLength;
  final bool enabled;
  final String? initialValue;
  final dynamic onChanged;
  final double? height;
  final bool primaryShadow;
  final TextEditingController? controller;
  final bool password;
  final bool rounded;
  final bool isError;
  final VoidCallback? onEnter;

  const TextInput({
    Key? key,
    required this.textName,
    this.icon,
    this.maskFormatter,
    this.onChanged,
    this.prefixIcon,
    this.maxLength = 200,
    this.type = 'text',
    this.controller,
    this.center = false,
    this.onEnter,
    this.node,
    this.height,
    this.enabled = true,
    this.initialValue,
    this.primaryShadow = false,
    this.password = false,
    this.margin = false,
    this.rounded = false,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const inputs = {
      'email': TextInputType.emailAddress,
      'number': TextInputType.number,
      'tel': TextInputType.phone,
      'text': TextInputType.text,
      'date': TextInputType.datetime
    };
    var numberFormatter = [];
    if (type == 'number') {
      numberFormatter = <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return Container(
      margin: margin ? const EdgeInsets.symmetric(horizontal: 25.0) : EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: height ?? 50.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: isError ? ColorResources.errorStatus : Colors.transparent, width: 2),
        color:  ColorResources.white,
      ),
      child: TextFormField(
        controller: controller,
        onEditingComplete: onEnter == null && node != null ? () => node?.nextFocus() : onEnter,
        onChanged: onChanged,
        enabled: enabled,
        obscureText: password,
        initialValue: initialValue,
        keyboardType: inputs[type],
        inputFormatters: maskFormatter != null ? [...numberFormatter, maskFormatter!] : null,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: icon,
          counterText: "",
          suffixIconConstraints: const BoxConstraints(),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(),
          hintText: textName,
          hintStyle: sansLight.copyWith(
            color: ColorResources.colorGray,
          ),
        ),
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: sansRegular.copyWith(
          color: ColorResources.black,
          fontWeight: FontWeight.w400,
          fontSize: Dimensions.fontSizeLarge,
        ),
      ),
    );
  }
}
