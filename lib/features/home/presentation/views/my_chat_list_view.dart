import 'package:complete_chat_app_tharwat/features/home/presentation/widgets/my_chat_list_view_body.dart';
import 'package:flutter/material.dart';

class MyChatListView extends StatelessWidget {
  final String currentUserId;
  const MyChatListView({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyChatListViewBody(currentUserId: currentUserId),
    );
  }
}
