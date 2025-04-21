import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final String chatId;
  final String otherUserId;
  final String otherUserName;

  const ChatView({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
  });

  static String id = 'chat_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatViewBody(
        chatId: chatId,
        otherUserId: otherUserId,
        otherUserName: otherUserName,
      ),
    );
  }
}
