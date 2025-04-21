import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_app_bar.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/message_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatefulWidget {
  final String chatId;
  final String otherUserId;
  final String otherUserName;

  const ChatViewBody({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            iconButton: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            text: widget.otherUserName,
            imageURL: 'assets/images/scholar.png',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index].data() as Map<String, dynamic>;
                    final isMe = msg['senderId'] == currentUserId;

                    return ChatBubble(
                      message: msg['text'],
                      isMe: isMe,
                      timestamp: msg['timestamp'] != null
                          ? (msg['timestamp'] as Timestamp).toDate()
                          : DateTime.now(),
                    );
                  },
                );
              },
            ),
          ),
          MessageInputField(
            controller: messageController,
            scrollController: _scrollController,
            chatId: widget.chatId,
            currentUserId: currentUserId,
          ),
        ],
      ),
    );
  }
}
