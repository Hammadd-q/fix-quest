import 'package:flutter/material.dart';

import 'Widgets.dart';

class MessageBubble extends StatelessWidget {
   const MessageBubble(
      {Key? key, required this.sender, required this.text, required this.isMe}) : super(key: key);

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          ChatMessageItem(
            isMeChatting: isMe,
            messageBody: text,
          ),
        ],
      ),
    );
  }
}