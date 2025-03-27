import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static String id = 'chat_view';
  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: ChatViewBody(email: email),
    );
  }
}
