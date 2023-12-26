import 'package:flutter/material.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  const BottomTabs({
    Key? key,
    required this.selectedTab,
    required this.tabPressed,
  }) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorResources.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: ImagesResources.home,
            selected: widget.selectedTab == 0,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabBtn(
            imagePath: ImagesResources.chat,
            selected: widget.selectedTab == 1,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            imagePath: ImagesResources.quizcenter,
            selected: widget.selectedTab == 2,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final VoidCallback onPressed;

  const BottomTabBtn({
    Key? key,
    required this.imagePath,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 10,
              color: Colors.transparent,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            color:
                selected ? ColorResources.colorSecondary : Colors.transparent,
          ),
          child: Image(
            image: AssetImage(imagePath),
            width: 22.0,
            height: 22.0,
            color: selected ? ColorResources.colorPrimary : ColorResources.grey,
          ),
        ),
      ),
    );
  }
}
