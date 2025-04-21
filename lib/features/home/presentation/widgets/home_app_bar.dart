import 'package:complete_chat_app_tharwat/core/widgets/custom_app_bar.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      text: "Chat",
      imageURL: 'assets/images/scholar.png',
      iconButton: IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
          );
        },
      ),
    );
  }
}
