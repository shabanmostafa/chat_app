import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/chat_view.dart';
import 'package:complete_chat_app_tharwat/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:complete_chat_app_tharwat/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class MyChatListViewBody extends StatefulWidget {
  final String currentUserId;

  const MyChatListViewBody({super.key, required this.currentUserId});

  @override
  State<MyChatListViewBody> createState() => _MyChatListViewBodyState();
}

class _MyChatListViewBodyState extends State<MyChatListViewBody> {
  final Map<String, Map<String, dynamic>> userCache = {};

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    if (userCache.containsKey(userId)) {
      return userCache[userId];
    } else {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data()!;
        userCache[userId] = data;
        return data;
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          HomeAppBar(),
          CustomSearchBar(currentUserId: widget.currentUserId),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Chats')
                  .where('participants', arrayContains: widget.currentUserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final chatDocs = snapshot.data!.docs;

                if (chatDocs.isEmpty) {
                  return const Center(
                      child: Text('No chats yet. Start a new one!'));
                }

                chatDocs.sort((a, b) {
                  final aData = a.data() as Map<String, dynamic>;
                  final bData = b.data() as Map<String, dynamic>;

                  final aTime = (aData['lastMessageTime'] != null)
                      ? aData['lastMessageTime'] as Timestamp
                      : Timestamp(0, 0);
                  final bTime = (bData['lastMessageTime'] != null)
                      ? bData['lastMessageTime'] as Timestamp
                      : Timestamp(0, 0);

                  return bTime.compareTo(aTime);
                });

                return ListView.builder(
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    final chat = chatDocs[index];
                    final List participants = chat['participants'];
                    final otherUserId = participants
                        .firstWhere((id) => id != widget.currentUserId);

                    final data = chat.data() as Map<String, dynamic>;
                    final lastMessage = data['lastMessage'] ?? '';
                    final lastTime = data['lastMessageTime'] != null
                        ? (data['lastMessageTime'] as Timestamp).toDate()
                        : null;

                    return FutureBuilder<Map<String, dynamic>?>(
                      future: getUserData(otherUserId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const ListTile(
                            leading: CircleAvatar(
                                child: CircularProgressIndicator()),
                            title: Text('Loading...'),
                          );
                        }

                        final userData = snapshot.data;
                        if (userData == null) {
                          return const ListTile(title: Text('User not found'));
                        }

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: userData['profileImageUrl'] != null
                                ? NetworkImage(userData['profileImageUrl'])
                                : null,
                            child: userData['profileImageUrl'] == null
                                ? Icon(Icons.person)
                                : null,
                          ),
                          title: Text(userData['name'] ?? 'Unknown'),
                          subtitle: Text(
                            lastMessage.isNotEmpty
                                ? lastMessage
                                : 'No messages yet',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: lastTime != null
                              ? Text(
                                  TimeOfDay.fromDateTime(lastTime)
                                      .format(context),
                                  style: const TextStyle(fontSize: 12),
                                )
                              : null,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatView(
                                  otherUserName: userData['name'] ?? 'Unknown',
                                  chatId: chat.id,
                                  otherUserId: otherUserId,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
