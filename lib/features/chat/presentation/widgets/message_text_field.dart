import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final ScrollController scrollController;
  final String email;
  // final VoidCallback onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.email,
    //  required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              messages.add({
                'text': controller.text,
                'email': email,
                'time': DateTime.now(),
              });
              controller.clear();
              scrollController.jumpTo(
                scrollController.position.minScrollExtent,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
