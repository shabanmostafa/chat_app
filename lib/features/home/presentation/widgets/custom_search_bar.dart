import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/chat_view.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String currentUserId;

  const CustomSearchBar({super.key, required this.currentUserId});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      _searchResults = result.docs;
    });
  }

  Future<String> getOrCreateChatId(String user1Id, String user2Id) async {
    final chatId = user1Id.hashCode <= user2Id.hashCode
        ? "$user1Id\_$user2Id"
        : "$user2Id\_$user1Id";

    final chatDocRef =
        FirebaseFirestore.instance.collection('Chats').doc(chatId);

    if (!(await chatDocRef.get()).exists) {
      await chatDocRef.set({
        'participants': [user1Id, user2Id],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: searchUsers,
            decoration: InputDecoration(
              hintText: "Search for users...",
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final user = _searchResults[index].data() as Map<String, dynamic>;
              final otherUserId = _searchResults[index].id;

              if (otherUserId == widget.currentUserId) {
                return const SizedBox.shrink();
              }
              return Material(
                child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(user['name']),
                    onTap: () async {
                      final chatId = await getOrCreateChatId(
                          widget.currentUserId, otherUserId);
                      _searchController.clear();
                      setState(() {
                        _searchResults = [];
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatView(
                            chatId: chatId,
                            otherUserId: otherUserId,
                            otherUserName: user['name'],
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
