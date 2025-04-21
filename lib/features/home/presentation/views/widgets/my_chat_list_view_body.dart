import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/chat_view.dart';
import 'package:complete_chat_app_tharwat/features/home/presentation/manager/cubit/chat_list_cubit.dart';
import 'package:complete_chat_app_tharwat/features/home/presentation/manager/cubit/chat_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_search_bar.dart';
import 'home_app_bar.dart';

class MyChatListViewBody extends StatefulWidget {
  final String currentUserId;

  const MyChatListViewBody({super.key, required this.currentUserId});

  @override
  State<MyChatListViewBody> createState() => _MyChatListViewBodyState();
}

class _MyChatListViewBodyState extends State<MyChatListViewBody> {
  late ChatListCubit _chatListCubit;

  @override
  void initState() {
    super.initState();
    _chatListCubit = ChatListCubit(widget.currentUserId)..fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const HomeAppBar(),
          CustomSearchBar(currentUserId: widget.currentUserId),
          Expanded(
            child: BlocBuilder<ChatListCubit, ChatListState>(
              bloc: _chatListCubit,
              builder: (context, state) {
                if (state is ChatListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatListFailure) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is ChatListSuccess) {
                  final chatDocs = state.chatDocs;
                  final userData = state.userData;

                  if (chatDocs.isEmpty) {
                    return const Center(
                        child: Text('No chats yet. Start a new one!'));
                  }

                  chatDocs.sort((a, b) {
                    final aTime = (a['lastMessageTime'] != null)
                        ? a['lastMessageTime'] as Timestamp
                        : Timestamp(0, 0);
                    final bTime = (b['lastMessageTime'] != null)
                        ? b['lastMessageTime'] as Timestamp
                        : Timestamp(0, 0);
                    return bTime.compareTo(aTime);
                  });

                  return ListView.builder(
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      final chat = chatDocs[index];
                      final participants = chat['participants'] as List;
                      final otherUserId = participants
                          .firstWhere((id) => id != widget.currentUserId);
                      final otherUser = userData[otherUserId];

                      final lastMessage = chat['lastMessage'] ?? '';
                      final lastTime = chat['lastMessageTime'] != null
                          ? (chat['lastMessageTime'] as Timestamp).toDate()
                          : null;

                      if (otherUser == null) {
                        return const ListTile(title: Text('Unknown user'));
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: otherUser['profileImageUrl'] != null
                              ? NetworkImage(otherUser['profileImageUrl'])
                              : null,
                          child: otherUser['profileImageUrl'] == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        title: Text(otherUser['name'] ?? 'Unknown'),
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
                                chatId: chat.id,
                                otherUserId: otherUserId,
                                otherUserName: otherUser['name'] ?? 'Unknown',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
