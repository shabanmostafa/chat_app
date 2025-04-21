import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageContentSection extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime timestamp;
  const MessageContentSection(
      {super.key,
      required this.message,
      required this.timestamp,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('hh:mm a').format(timestamp);

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          formattedTime,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
