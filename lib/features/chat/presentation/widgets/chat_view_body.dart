import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_app_bar.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/widgets/message_text_field.dart';
import 'package:flutter/material.dart';

class ChatViewBody extends StatefulWidget {
  ChatViewBody({super.key, required this.email});
  final String email;
  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(text: "Chat", imageURL: 'assets/images/scholar.png'),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .orderBy('time', descending: true) // ترتيب الرسائل من الأحدث
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
                controller: _scrollController, // ✅ نربطه هنا

                reverse: true, // لجعل آخر رسالة تظهر في الأسفل دائمًا
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> msg =
                      messages[index].data() as Map<String, dynamic>;

                  return ChatBubble(
                    message: msg["text"],
                    isMe: msg["email"] == widget.email,
                    timestamp: (msg["time"] as Timestamp).toDate(),
                  );
                },
              );
            },
          ),
        ),
        MessageInputField(
          email: widget.email,
          controller: messageController,
          scrollController: _scrollController, // ✅ نمرره هنا
        ),
      ],
    );
  }
}
