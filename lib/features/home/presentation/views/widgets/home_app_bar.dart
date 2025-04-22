import 'package:complete_chat_app_tharwat/core/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      text: "Chats",
      imageURL: 'assets/images/scholar.png',
      iconButton: IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () => FirebaseAuth.instance.signOut(),
      ),
    );
  }
}
