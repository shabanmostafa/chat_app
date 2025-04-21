import 'package:complete_chat_app_tharwat/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/widgets/chat_view_body.dart';

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
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return BlocProvider(
      create: (_) => ChatCubit(chatId: chatId, currentUserId: currentUserId),
      child: ChatViewBody(
        chatId: chatId,
        otherUserId: otherUserId,
        otherUserName: otherUserName,
      ),
    );
  }
}
