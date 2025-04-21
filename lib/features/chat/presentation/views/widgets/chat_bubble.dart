import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/widgets/message_content_section.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? primaryColor : Color(0xff006d84),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe ? Radius.zero : const Radius.circular(16),
            bottomRight: isMe ? const Radius.circular(16) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: MessageContentSection(
          message: message,
          timestamp: timestamp,
          isMe: isMe,
        ),
      ),
    );
  }
}
