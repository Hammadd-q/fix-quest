import 'package:flutter/material.dart';
import 'package:hip_quest/util/Utils.dart';
import 'package:provider/provider.dart';


class ChatMessageItem extends StatelessWidget {
  final bool isMeChatting;
  final String messageBody;

  const ChatMessageItem({
    Key? key,
    required this.isMeChatting,
    required this.messageBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: isMeChatting ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(

              margin: const EdgeInsets.symmetric(
                vertical: 2,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: isMeChatting
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
                    : const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: isMeChatting
                    ? ColorResources.colorPrimary
                    : ColorResources.colorSecondary,
              ),
              child: Text(
                messageBody,
                style: sansLight.copyWith(
                  color: isMeChatting ? ColorResources.white : ColorResources.black,
                  fontSize: Dimensions.fontSizeMedium,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),

              ),
            ),
          ),
        ],
      );

  }
}
