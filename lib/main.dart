import 'package:complete_chat_app_tharwat/features/home/presentation/views/my_chat_list_view.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/login_view.dart';
import 'package:complete_chat_app_tharwat/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MyChatListView(
                currentUserId: FirebaseAuth.instance.currentUser!.uid);
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
