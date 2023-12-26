import 'package:flutter/material.dart';
import 'package:hip_quest/util/ColorResources.dart';
import 'package:hip_quest/util/Utils.dart';

class CourseContent extends StatelessWidget {
  final String number;

  final String title;
  final VoidCallback onClick;
  final bool isClick;

  const CourseContent({
    Key? key,
    required this.number,
    required this.title,
    required this.onClick,
    this.isClick = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                  width: 24,
                  height: 24,
                  child: isClick
                      ? Image.asset(ImagesResources.checktrue)
                      : Image.asset(
                          ImagesResources.checktrue,
                          color: ColorResources.grey,
                        )),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(number,
                      style: sansSemiBold.copyWith(
                          color: ColorResources.colorPrimary,
                          fontSize: Dimensions.iconSizeDefault,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 5),
                  SizedBox(
                      width: 200,
                      child: Text(title,
                          maxLines: 2,
                          style: sansSemiBold.copyWith(
                              color: ColorResources.black,
                              fontSize: Dimensions.fontSizeMedium,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left)),
                ],
              ),
              SizedBox(
                width: 41,
                height: 41,
                child: Image.asset(ImagesResources.videochapter),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 10,bottom: 10),
              width: double.infinity,
              height: 1,
              decoration:
                  const BoxDecoration(color: ColorResources.colorPrimary)),
        ],
      ),
    );
  }
}
