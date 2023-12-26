import 'package:flutter/material.dart';
import 'package:hip_quest/util/Utils.dart';

class SelectInput extends StatefulWidget {
  final String textName;
  final List<String> listItem;
  final dynamic onChange;
  String? valueChoose;

  SelectInput({
    Key? key,
    required this.textName,
    required this.listItem,
    required this.onChange,
    this.valueChoose,
  }) : super(key: key);

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        color: ColorResources.selectInputColor,
      ),
      height: 50.0,
      child: DropdownButton(
        hint: Text(
          widget.textName,
          style: sansRegular.copyWith(
            color: ColorResources.black,
          ),
        ),
        isExpanded: true,
        dropdownColor: ColorResources.selectInputColor,
        value: widget.valueChoose,
        onChanged: (String? value) {
          setState(() {
            widget.valueChoose = value;
            widget.onChange(value);
          });
        },
        underline: const SizedBox(height: 0),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: ColorResources.colorPrimary,
        ),
        items: List.generate(widget.listItem.length, (index) {
          return DropdownMenuItem<String>(
              value: widget.listItem[index],
              child: Text(
                widget.listItem[index],
                style: sansRegular.copyWith(
                  color: ColorResources.black,
                  fontSize: Dimensions.fontSizeMedium,
                ),
              ),
          );
          // return DropdownMenuItem<String>(
          //   value: "${widget.listItem[index].id}",
          //   child: Text(
          //     widget.listItem[index].name,
          //     style: novaRegular.copyWith(
          //       color: ColorResources.black,
          //       fontSize: Dimensions.fontSizeMedium,
          //     ),
          //   ),
          // );
        }),
      ),
    );
  }
}
