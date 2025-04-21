import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final ScrollController scrollController;
  final String chatId;
  final String currentUserId;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.chatId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final messagesRef = FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatId)
        .collection('messages');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await messagesRef.add({
                  'text': controller.text.trim(),
                  'senderId': currentUserId,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                await FirebaseFirestore.instance
                    .collection('Chats')
                    .doc(chatId)
                    .update({
                  'lastMessage': controller.text.trim(),
                  'lastMessageTime': FieldValue.serverTimestamp(),
                });

                controller.clear();

                Future.delayed(const Duration(milliseconds: 100), () {
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
              }
            },
            icon: const Icon(Icons.send, color: primaryColor),
          )
        ],
      ),
    );
  }
}
